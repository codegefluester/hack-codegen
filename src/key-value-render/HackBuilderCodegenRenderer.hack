/*
 *  Copyright (c) 2015-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HackCodegen\_Private;


use type Facebook\HackCodegen\{
  HackBuilder,
  IHackBuilderValueRenderer,
  ICodeBuilderRenderer,
  IHackCodegenConfig,
};

final class HackBuilderCodegenRenderer
implements IHackBuilderValueRenderer<ICodeBuilderRenderer> {

  final public function render(
    IHackCodegenConfig $config,
    ICodeBuilderRenderer $value,
  ): string {
    $b = new HackBuilder($config);
    $value->appendToBuilder($b);
    return $b->getCode();
  }
}
