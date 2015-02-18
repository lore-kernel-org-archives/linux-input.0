From: simon@mungewell.org
Subject: Re: [PATCH v2 0/4] HID: hid-lg4ff: Improve handling of Logitech
 multimode gaming wheels
Date: Tue, 17 Feb 2015 21:27:09 -0500
Message-ID: <4d0b665f891becad61fe173397cb88a2.squirrel@mungewell.org>
References: <1423965785-22930-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:34501 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbBRC1N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 21:27:13 -0500
In-Reply-To: <1423965785-22930-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?iso-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>

> This patch series improves handling of various Logitech gaming wheels=
 and
> allows switching between various compatibility modes which might be u=
seful
> to improve compatibility with very old games and testing purposes.
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
>
> v2: - Rebased against latest linux-next
>     - Document the newly introduced sysfs interfaces in appropriate
> commits
>     - Assume that we are targeting kernel version 4.1
>     - Fix a misleading error message regarding unsupported wheel mode

This version looks good to me; tested with WiiWheel, DFP and G27.

Thanks,
Simon
--

tested-by: Simon Wood <simon@mungewell.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
