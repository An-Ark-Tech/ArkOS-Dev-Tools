/*
 * @file @pkgname@.hpp
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

#ifndef Ark_ArkOS_@Pkgname@_HPP_
#define Ark_ArkOS_@Pkgname@_HPP_

#include <ArkOS.hpp>
#include <rtt/Component.hpp>
#include <rtt/Port.hpp>
#include <rtt/Property.hpp>
#include <rtt/RTT.hpp>
#include <rtt/TaskContext.hpp>
#include <rtt/Time.hpp>
#include <rtt/marsh/Marshalling.hpp>
#include <rtt/marsh/MarshallingService.hpp>
#include <rtt/os/TimeService.hpp>

namespace Ark
{
namespace ArkOS
{

/**
 * @brief todo add the component overview
 *
 * todo add the component description
 *
 */

class @Pkgname@ : public Ark::ArkOS::Base::ArkComponent
{
  public:
    /**
     * Constructor of @Pkgname@.
     *
     * Allocate memory and initialize the Component.
     * @param name input: @Pkgname@ instance name
     */
   @Pkgname@(std::string const &name);

  protected:
    /**
     * The Configuration Hook.
     * On failure, the component will not be able to start.
     *
     * @return true if configuration succeeded, false otherwise.
     */
    bool configureHook();

    /**
     * executed when start() is called for the component
     *
     * @return true if start succeeded, false otherwise.
     */
    bool startHook();

    /**
     * executed when an update is triggered on the component
     */
    void updateHook();

    /**
     * executed when stop() is called for the component
     */
    void stopHook();

    /**
     * executed when component is removed from memory
     */
    void cleanupHook();
};

} // namespace ArkOS
} // namespace Ark
#endif /* Ark_ArkOS_@PKGNAME@_HPP_ */

