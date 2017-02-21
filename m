From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 07:49:27 -0800
Message-ID: <CA+55aFyBkUWy+Qpm6XxyEUi-FU_YSj-r01aRLuh0qoTm_vSq9g@mail.gmail.com>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm>
 <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com>
 <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com>
 <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm> <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
 <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 21, 2017 at 7:46 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Tue, 21 Feb 2017, Linus Torvalds wrote:
>>
>> .. and maybe we should do this same thing for the WACOM case a couple
>> of lines up from your patch?
>
> Well, that's far more questionable. I am pretty sure Wacom devices are
> completely dysfunctional without a specific driver, as they have their own
> protocol.

Ah, ok. Never mind then.

            Linus
