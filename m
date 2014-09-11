From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Thu, 11 Sep 2014 19:31:13 +0200
Message-ID: <5411DC61.2050003@redhat.com>
References: <1410425447-9575-1-git-send-email-hdegoede@redhat.com> <1410425447-9575-3-git-send-email-hdegoede@redhat.com> <20140911172619.GD13083@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44123 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaIKRbX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 13:31:23 -0400
In-Reply-To: <20140911172619.GD13083@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi,

On 09/11/2014 07:26 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Thu, Sep 11, 2014 at 10:50:47AM +0200, Hans de Goede wrote:
>> @@ -722,6 +723,13 @@ static int psmouse_extensions(struct psmouse *psmouse,
>>  {
>>  	bool synaptics_hardware = false;
>>  
>> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
>> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
>> +		/* Not supported yet, use bare protocol */
>> +		psmouse_max_proto = max_proto = PSMOUSE_PS2;
>> +		goto reset_to_defaults;
> 
> Why do we need to jump to a new label instead of simply saying

Once we had figured out that psmouse.proto=bare at least made this
touchpad work in mouse emulation mode, that is the first thing I did, but it
is not enough. We also need to set psmouse_max_proto to short-circuit
psmouse_initialize and do the reset.

I'm trying to get access to one of the affected laptops to see if we can
do better.

Regards,

Hans
