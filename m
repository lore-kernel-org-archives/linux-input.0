From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [RFC] Generic implementation for Input enable disable methods
Date: Fri, 22 Jan 2010 08:28:20 +0200
Message-ID: <1264141700.2889.14.camel@4fid08082>
References: <1263968920.18053.24.camel@4fid08082>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23603 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0AVG2m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2010 01:28:42 -0500
In-Reply-To: <1263968920.18053.24.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Westerberg Mika.1" <ext-mika.1.westerberg@nokia.com>, "Nikula Jani.1" <ext-jani.1.nikula@nokia.com>

On Wed, 2010-01-20 at 07:28 +0100, Onkalo Samu.P (Nokia-D/Tampere)
wrote:
> Hi
> 
> Some time ago, there were two parallel implementation proposals for
> disabling input devices. See following email:
> http://www.spinics.net/lists/linux-input/msg05984.html
> 
> It was asked to combine these two to have generic interface.
> I'm proposing following sysfs interface:
> 
> ../input0/disable/avail_xx
> ../input0/disable/disable_xx
> 
> So, new directory for disable control entries. Own entries for each
> of the events or event group. Implementation is using bitmap format:
> 
> Examples
> 
> See what event groups can be disabled. Disable and enable all the groups
> # cat avail_ev
> 0-1,4,20
> # echo "0-1,4,20" > disable_ev
> # cat disable_ev
> 0-1,4,20
> # echo -e "\0" > disable_ev
> # cat disable_ev
>  
> See what individual events can be disabled. Disable and enable one of
> them:
> # cat avail_key
> 528
> # echo "528" > disable_key
> # cat disable_key
> 528
> # echo -e "\0" -> disable_key
> # cat disable_key
> 

After some playing with this interface it is quite clear that this is
not very user friendly. To have better usability, I'll change my
proposal to following one:

Entries are changed to this format:
.../inputx/disable/enable_xx
.../inputx/disable/disable_xx
(no avail_xx anymore)

Use:
echo "1,2" > disable_xx  disable events 1 and 2
echo "" > disable_xx   do nothing
cat disable_xx   list of currently disabled entries

echo "4-5" > enable_xx enable events 4,5,6
echo "" > enable_xx  do nothing
cat enable_xx   list of currenty enabled entries

Read operation returns only events which can be controlled via this
interface.

Enable all currently disabled events:
cat disable_xx > enable_xx

Disable all currently enabled events:
cat enable_xx > disable_XX

This way it is much easier to control individual events.

> Input core just provides sysfs entries and call call-back functions. 
> Actual work is done in the drivers like gpio-keys.
> 
> Does this interface sound acceptable solution?
> If it is, I'll finalize my implentation and send it for review.
> This interface is tested to work with twl4030_keypad driver and
> gpio-keys. It should also work fine with touch screen input drivers.
> 
> This is more or less small embedded device feature. Should it be behind
> configuration flags similar to CONFIG_PM? Of course this would introduce
> some compilation flags to the input-core.
> 
> Regard,
> Samu
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

