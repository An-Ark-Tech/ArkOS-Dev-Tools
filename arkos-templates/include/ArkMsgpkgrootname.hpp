/**
 * @file    @pkgname@.hpp
 *
 * @brief   todo add description
 *
 * @author  todo
 *
 * @date    @today@
 *
 * @copyright@
 *
 */

#ifndef Ark_ArkOS_@PKGNAME@_HPP_
#define Ark_ArkOS_@PKGNAME@_HPP_

/**
 * In this header you may define a number of classes or structs,
 * which will be picked up by the typegen tool.
 *
 * typegen will not process headers included by this header.
 * If you want to generate type support for another header than
 * this one, add that header in the CMakeLists.txt file.
 */

#include <ArkMsgBase/ArkMsgBase.hpp>
#include <vector>

namespace Ark
{
namespace ArkOS
{
/**
 * Just an example class. You may remove/modify it.
 * Note that there are restrictions. Take a look at the
 * Orocos typekit plugin manuals and the typegen documentation.
 */
class @PKGNAME@ : public ArkMsgBase
{
  public:
    /** Contains a sequence of doubles. */
    std::vector<double> samples;
};

} // namespace ArkOS
} // namespace Ark

#endif // Ark_ArkOS_@PKGNAME@_HPP_
