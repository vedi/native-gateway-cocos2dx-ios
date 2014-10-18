//
// Created by Shubin Fedor on 16/10/14.
//

#include "Cocos2dxGatewayAdapter.h"
#include "DictJsonSerializer.h"
#include "ProcessorEngine.h"

void Cocos2dxGatewayAdapter::dispatch(const char *strParams, std::string &retStr) {
    retStr.clear();
    NSDictionary *dictParams = [DictJsonSerializer deserialize:strParams];
    if (dictParams == nil) {
        retStr.append("{}");
        return;
    }

    NSDictionary *retDictParams = [[ProcessorEngine sharedInstance] proceed:dictParams];

    if (retDictParams == nil) {
        retStr.append("{}");
        return;
    }

    const char *res = [DictJsonSerializer serialize:retDictParams];
    retStr.append(res);
    delete res;
}
