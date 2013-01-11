From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH resend 2/2] Input: twl6040-vibra: Code cleanup in probe
 with devm_* conversion
Date: Fri, 11 Jan 2013 10:11:04 +0100
Message-ID: <50EFD728.8090204@ti.com>
References: <1357824965-30614-1-git-send-email-peter.ujfalusi@ti.com> <1357824965-30614-3-git-send-email-peter.ujfalusi@ti.com> <20130110175421.GC2797@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46386 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab3AKJLH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2013 04:11:07 -0500
In-Reply-To: <20130110175421.GC2797@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 01/10/2013 06:54 PM, Dmitry Torokhov wrote:
> Hi Peter,
>=20
> On Thu, Jan 10, 2013 at 02:36:05PM +0100, Peter Ujfalusi wrote:
>> Convert the probe to use devm_*. At the same time reorder the calls
>> so we will register the input device as the last step when the drive=
r
>> is loaded.
>=20
> If you are doing this please also use devm_input_allocate_device() an=
d
> devm_regulator_bulk_get().

Now I remember: I can not switch to devm_regulator_bulk_get() unfortuna=
tely
since when we boot with DT the code needs to reach up for the parent's =
dev to
get the needed regulator. If I use devm_regulator_bulk_get() the resour=
ce will
be bind to the parent dev and not to the vibra driver.

> I also think it is high time to get rid of
> dedicated work queue - cwq hasn't actually given you a separate thera=
d
> for a while now and if you get rid of workqueue you can get ridof ent=
ire
> twl6040_vibra_remove().

I agree with the rest. I'll move both twl4030/6040 vibra to use
devm_input_allocate_device() and also I will move them to use system wi=
de
workqueue.

I'm going to resend the series soon with the suggested changes.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
