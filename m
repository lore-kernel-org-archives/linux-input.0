From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Wed, 5 Dec 2018 13:56:54 -0800
Message-ID: <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Tue, 4 Dec 2018 at 16:42, Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> A full explanation of why and what is in the v1, v2 patch thread here:
> https://lkml.org/lkml/2018/11/22/625
>
> v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch
> moved in the ordering. This is a full patch sequence because Benjamin's
> magic scripts struggle with singular updates ;)

I've retested with the same Logitech mice as before, except for the MX
Anywhere 2S, which is currently not available to me. So, for
reference, that's the MX Master 2S, Performance MX, M560, Anywhere MX,
and the M325 (to check low-resolution scrolling).

Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
