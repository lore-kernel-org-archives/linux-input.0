From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Prevent sending reports from racing with
 device reset
Date: Mon, 4 Jan 2016 07:55:02 -0800
Message-ID: <CAOhV88NznpiQJH3RiyYXO0zomGF7wuhEHABLaK_sy2axVM2d=w@mail.gmail.com>
References: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 21, 2015 at 5:26 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
<snip>
> Below is what happens to touchpad on Lenovo Yoga 900 during resume from
> system sleep:

<snip>

> Reported-by: Nish Aravamudan <nish.aravamudan@gmail.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Probably not necessary, but this can be updated to

Reported-and-tested-by: Nish Aravamudan <nish.aravamudan@gmail.com>

-Nish
