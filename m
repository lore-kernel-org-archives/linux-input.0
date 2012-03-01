From: Eric Paris <eparis@parisplace.org>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Thu, 1 Mar 2012 10:15:06 -0500
Message-ID: <CACLa4ps8wrhBU+2t7M-hNMoxNDvfSbKy=x3iOnXZtoHkSr9ahQ@mail.gmail.com>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
	<CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
	<CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
	<1330609674.2398.18.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46396 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab2CAPPH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 10:15:07 -0500
Received: by vcqp1 with SMTP id p1so524725vcq.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 07:15:06 -0800 (PST)
In-Reply-To: <1330609674.2398.18.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, linux-input@vger.kernel.org

On Thu, Mar 1, 2012 at 8:47 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2012-03-01 at 08:39 -0500, Eric Paris wrote:
>> On Wed, Feb 29, 2012 at 4:37 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> > On Wed, Feb 29, 2012 at 4:00 PM, Eric Paris <eparis@parisplace.org> wrote:

> I think working on the kernel's fried your brain Eric ;)

You seem to mistakenly believe my brain was ever not fried...

> xinput needs an X display. udev doesn't know that display. You can
> instead use Jon's script with this, if you use GNOME 3:
> http://who-t.blogspot.com/2011/03/custom-input-device-configuration-in.html
>
> More examples at:
> http://git.gnome.org/browse/gnome-settings-daemon/tree/plugins/common/input-device-example.sh

So obviously I don't know how to get the scroll wheel click to work,
but remapping the thumb buttons works great!  Thanks so much everyone!
 /me wonders how long it will take to remember how to set this up
after next reinstall.

$ gsettings set org.gnome.settings-daemon.peripherals.input-devices
hotplug-command $HOME/scripts/input-devices.sh
$ cat /home/eparis/scripts/input-devices.sh
#!/bin/sh

args=`getopt "t:i:" $*`

set -- $args

while [ $# -gt 0 ]
do
    case $1 in
    -t)
        shift;
        type="$1"
        ;;
     -i)
        shift;
        id="$1"
        ;;
     --)
        shift;
        device="$@"
        break;
        ;;
    *)
        echo "Unknown option $1";
        exit 1
        ;;
    esac
    shift
done

retval=0

case $type in
        added)
		# Forward/Back thumb buttons to 'middle' click
		if [ "$device" = "Logitech MX Revolution Mouse" ]; then
        		/usr/bin/xinput set-button-map "$device" 1 2 3 4 5 6 2 2 >>
/tmp/logitech 2>&1
		fi
		;;
        present)
		# Forward/Back thumb buttons to 'middle' click
		if [ "$device" = "Logitech MX Revolution Mouse" ]; then
        		/usr/bin/xinput set-button-map "$device" 1 2 3 4 5 6 2 2 >>
/tmp/logitech 2>&1
		fi
                ;;
        removed)
                ;;
        *)
                echo "Unknown operation"
                retval=1
                ;;
esac

# All further processing will be disabled if $retval == 0
exit $retval
