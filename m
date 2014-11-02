From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 0/4] Fixes for ALPS driver
Date: Sun, 02 Nov 2014 15:14:55 +0100
Message-ID: <54563C5F.10702@redhat.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com> <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaKBOPF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Nov 2014 09:15:05 -0500
In-Reply-To: <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 11/02/2014 12:25 AM, Pali Roh=C3=A1r wrote:
> This patch series tries to fix problems with ALPS dualpoint devices o=
n Dell
> Latitude laptops which are probably caused by bugs in Dell BIOS, Dell=
 EC or
> in ALPS touchpad firmware itself.
>=20
> Root of problems is yet unknown but at least this patch series could =
eliminate
> reporting bogus data to userspace.
>=20
> Reported bugs:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1258837
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1320022
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1272624
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1145954
>=20
> Pali Roh=C3=A1r (4):
>   input: alps: Do not try to parse data as 3 bytes packet when driver
>     is out of sync
>   input: alps: Allow 2 invalid packets without resetting device
>   input: alps: For protocol V3, do not process data when last packet'=
s
>     bit7 is set
>   input: alps: Fix trackstick detection
>=20
>  drivers/input/mouse/alps.c |  113 +++++++++++++++++++++++++++++++---=
----------
>  1 file changed, 80 insertions(+), 33 deletions(-)

Thanks for working on this, patches 1-3 are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Patch 4 is too much work to review on a Sunday :), so I'll leave
reviewing it to Dmitry.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
