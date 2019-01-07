From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: rotary_encoder - Support key events
Date: Sun, 6 Jan 2019 18:38:44 -0600
Message-ID: <CAKdAkRTL0dBMxAk7uUEexF8uXba+cr+POU5ysLv5830SMPjHzQ@mail.gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-2-nazgul33@gmail.com>
 <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com> <CAEo1Rizj_HC5f+TWMP8ogrsXVhMDrxA+Nyo2h4KJJ4admtmanQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEo1Rizj_HC5f+TWMP8ogrsXVhMDrxA+Nyo2h4KJJ4admtmanQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nazgul33 <nazgul33@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 5, 2019 at 9:36 PM nazgul33 <nazgul33@gmail.com> wrote:
>
> input_sync() is there, at the end of the function.

I know. Nonetheless, you need another one between sending distinct key
events. Userspace is allowed to accumulate device state until
EV_SYN/SYN_REPORT is received, which can result in your key events
being a noop.

Thanks.

-- 
Dmitry
