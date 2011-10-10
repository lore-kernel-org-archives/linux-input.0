From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/6] ASoC/MFD/Input: twl6040: Support for audio driven vibra
Date: Mon, 10 Oct 2011 21:36:57 +0300
Message-ID: <CAPo=G1xD0=UrSvdckEU2n-W8LqSQxQwxVPfnVF0WOd2wUrjuFA@mail.gmail.com>
References: <1316760584-27426-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:45300 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab1JJSg7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 14:36:59 -0400
In-Reply-To: <1316760584-27426-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

Hi Samuel, Dmitry,

On Fri, Sep 23, 2011 at 9:49 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> Hello,
>
> Changes since v1:
> - Patches already taken by Mark has been removed
> - Patch 4: Return -EBUSY instead of -EPERM

Would you be able to comment on this series?
I need to send v3 since ASoC moved ahead, and this series no longer
applies cleanly.

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
