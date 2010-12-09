From: "Arce, Abraham" <x0066660@ti.com>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 9 Dec 2010 00:34:15 -0600
Message-ID: <AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36168 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754543Ab0LIGeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 01:34:17 -0500
In-Reply-To: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org, arve@android.com

Hi Daniel,

On Wed, Dec 8, 2010 at 6:24 PM, Daniel Walker <dwalker@codeaurora.org> =
wrote:
> This adds matrix keypad support, and gpio buttons support for
> trout's various keys and buttons.
>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> ---
> =A0arch/arm/mach-msm/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-msm/board-trout-keypad.c | =A0342 ++++++++++++++++++=
++++++++++++++
> =A02 files changed, 343 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-msm/board-trout-keypad.c
>

[...]

> +
> +static unsigned int trout_col_gpios_evt2[] =3D { 35, 34, 33, 32, 31,=
 23, 30, 109 };

WARNING: line over 80 characters

[...]

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
