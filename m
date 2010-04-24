From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue is not empty.
Date: Fri, 23 Apr 2010 21:58:56 -0700
Message-ID: <v2sd6200be21004232158m3a3eaebai1ca0e49ae79e97f@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	 <1271984938-13920-2-git-send-email-arve@android.com>
	 <1271984938-13920-3-git-send-email-arve@android.com>
	 <1271984938-13920-4-git-send-email-arve@android.com>
	 <1271984938-13920-5-git-send-email-arve@android.com>
	 <1271984938-13920-6-git-send-email-arve@android.com>
	 <1271984938-13920-7-git-send-email-arve@android.com>
	 <1271984938-13920-8-git-send-email-arve@android.com>
	 <1271984938-13920-9-git-send-email-arve@android.com>
	 <20100423135625.1e12d005.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:61656 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0DXE66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 00:58:58 -0400
In-Reply-To: <20100423135625.1e12d005.randy.dunlap@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Sven Neumann <s.neumann@raumfeld.com>, Tero Saarni <tero.saarni@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Matthew Garrett <mjg@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

2010/4/23 Randy Dunlap <randy.dunlap@oracle.com>:
> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
>
>> Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that w=
ill block
>> suspend while the event queue is not empty. This allows userspace co=
de to
>> process input events while the device appears to be asleep.
>
>
> All new ioctls need to be added to Documentation/ioctl/ioctl-number.t=
xt, please.
>

These two appear to already be covered by "'E'     all
linux/input.h           conflict!", but I will add a line the user
space suspend blocker ioctls added earlier in this patch set.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
