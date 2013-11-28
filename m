From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [RFC][PATCH] Input: define keys for WWAN and SES
Date: Thu, 28 Nov 2013 13:06:35 +0100
Message-ID: <529731CB.3010107@hauke-m.de>
References: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:43752 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab3K1MGq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 07:06:46 -0500
In-Reply-To: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 11/28/2013 12:48 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
> This is just a RFC, so be nice to this "patch", please ;)
>=20
> My goal is to add support for buttons on bcm47xx arch. However after
> analyzing existing database of devices I realized I don't know what c=
ode
> I should assign to some buttons.
>=20
> First of all, older routers often have a "SES" button. SES stands for
> SecureEasySetup and is Broadcom's proprietary protocol which was late=
r
> replaced with WPS (Wi-Fi Protected Setup).
> Btw. WPS appeared to be broken because it's easy to attack it with
> brutal-force method.

Only a badly implemented WPS pin authentication is vulnerable to the
brute force attack, as far as I know.

> I'm not sure if any distribution have any interest
> in using that buttons, but it still would be nice to have support for
> them in kernel. One option is to add KEY_SES for this purpose.
> Is this the right way? It's similar to the KEY_WPS_BUTTON, but I want=
ed
> to somehow distinct them. Is there any other option? Should I use
> KEY_UNKNOWN or BTN_MISC or BTN_n?

I do not think you or someone else plans to implement SecureEasySetup o=
n
a device running current Linux kernel, why not use the WPS button key
for for these button. If someone wants to implement this just use the
WPS button key for that.

> Another thing is WWAN key. Some routers support mobile networks (for
> example Linksys 54G3G) and they may have button for enabling/disablin=
g
> such connection. We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB,
> but nothing for WWAN device control. I guess in future KEY_WWAN could
> be also supported in rfkill by mapping it to the RFKILL_TYPE_WWAN.
>=20
> What do you think about this?
> ---
>  include/uapi/linux/input.h |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 4649ee3..a06c8bf 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -749,6 +749,9 @@ struct input_keymap_entry {
>  #define BTN_TRIGGER_HAPPY39		0x2e6
>  #define BTN_TRIGGER_HAPPY40		0x2e7
> =20
> +#define KEY_WWAN			0x2e8	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
> +#define KEY_SES				0x2e9	/* SecureEasySetup */
> +
>  /* We avoid low common keys in module aliases so they don't get huge=
=2E */
>  #define KEY_MIN_INTERESTING	KEY_MUTE
>  #define KEY_MAX			0x2ff
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
