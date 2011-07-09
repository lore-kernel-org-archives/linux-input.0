From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 03/12] Input: synaptics - fix minimum reported ABS_TOOL_WIDTH
Date: Fri, 8 Jul 2011 23:24:09 -0700
Message-ID: <CAMu+ixjT7dXBx-vtuL6BOBdiLZkRy-ZeaxZc37um3T=wqxO-pQ@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org> <1309324042-22943-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1GIGYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 02:24:50 -0400
In-Reply-To: <1309324042-22943-4-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Tue, Jun 28, 2011 at 10:07 PM,  <djkurtz@chromium.org> wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
>
> Synaptics touchpads report a 'w' value in each data report.
> For touchpads that support palm detection, when there is a single fin=
ger
> on the pad, the 'w' value reports its width in the range 4 to 15.
> Thus, the minimum valid width is 4.
>
> Note: Other values of 'w' are used to report special conditions:
> =A0w=3D0: 2 fingers are on the pad
> =A0w=3D1: 3 or more fingers are on the pad
> =A0w=3D2: the packet contains "Advanced Gesture Mode" data.

Ideally we should scale this to a physically meaningful quantity
instead, such as surface units.  That would require knowing the
distance between each capacitive touch channel and then scaling W - 4
by that amount before reporting it.

These values are all kind of mysterious to user-space anyways unless
the physical nature of the device is known by other means (such as
configuration files).

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
