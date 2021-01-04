/*
 * @file @pkgname@.cpp
 *
 * @brief todo add description
 *
 * @author  todo
 *
 * @date    @today@
 *
 * @copyright@
 *
 */

#include "@pkgname@.hpp"

namespace Ark
{
namespace ArkOS
{

@Pkgname@::@Pkgname@(std::string const &name)
    : Ark::ArkOS::Base::ArkComponent(name, PreOperational)
{
    /*
     * Add your code here
     * to be executed when component is loaded by the deployer
     */
    InfoLog("constructed Successfully!");
}

bool @Pkgname@::configureHook()
{
    /*
     * Add your code here
     * to be executed when configure() is called.
     *
     * Return true to indicate that the configuration
     * is successful.
     * Otherwise, return false
     */
    InfoLog("configured Successfully!");
    return true;
}

bool @Pkgname@::startHook()
{
    /*
     * Add your code here
     * to be executed when start() is called.
     *
     * Return true to indicate that the start procedure has been successful.
     * Otherwise, return false
     *
     */
    InfoLog("started Successfully!");
    return true;
}

void @Pkgname@::updateHook()
{
    /*
     * In case you need to use the RTT::Logger instead of the OCL logger,
     * which is not recommended, please add the following line at the
     * beginning of the UpdateHook():
     *   RTT::Logger::In in(this->getName().data());
     */

    /* Add your own code */
}

void @Pkgname@::stopHook()
{
    /*
     * Add your code here
     * to be executed when stop() is called.
     */
    InfoLog("stopped Successfully!");
}

void @Pkgname@::cleanupHook()
{
    /*
     * Add your code here
     * to be executed when component is removed from memory
     */
    InfoLog("cleaned Successfully!");
}

} // namespace ArkOS
} // namespace Ark

ORO_CREATE_COMPONENT_LIBRARY()
ORO_LIST_COMPONENT_TYPE(Ark::ArkOS::@Pkgname@)
