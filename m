From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 0/4] E6 bug fix and code cleanup
Date: Wed, 27 Jun 2012 09:56:35 -0700
Message-ID: <CANRwn3SgoGNWpVbwjeC-SvWjC9+fq=busBNmfQF41aLYXqefog@mail.gmail.com>
References: <1340660124-27323-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47826 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764Ab2F0Q4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jun 2012 12:56:36 -0400
Received: by wibhr14 with SMTP id hr14so1287212wib.1
        for <linux-input@vger.kernel.org>; Wed, 27 Jun 2012 09:56:35 -0700 (PDT)
In-Reply-To: <1340660124-27323-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Jun 25, 2012 at 2:35 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> The first two patches fix 0xE6 bug. The other two are just cleanup.
>
> Ping Cheng (4):
> =C2=A0input - wacom: fix retrieving touch_max bug
> =C2=A0input - wacom: don't retrieve touch_max when it is predefined
> =C2=A0input - wacom: BTN_TOOL_DOUBLETAP is not a valid device_type
> =C2=A0input - wacom: TPC2FG doesn't store touch id for slots
>
> =C2=A0drivers/input/tablet/wacom_sys.c | =C2=A0 =C2=A08 +++++---
> =C2=A0drivers/input/tablet/wacom_wac.c | =C2=A0 =C2=A06 ++++--
> =C2=A02 files changed, 9 insertions(+), 5 deletions(-)
>
> --
> 1.7.7.6
>
> --

Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
