From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] HID: i2c-hid: Prevent sending reports from racing with
 device reset
Date: Sun, 27 Dec 2015 18:10:10 -0800
Message-ID: <CA+55aFwh13JJ8s-7+Tc48npW4N1NpDod4DKdJTcQh5u+mQbVeg@mail.gmail.com>
References: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33595 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbL1CKL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2015 21:10:11 -0500
In-Reply-To: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 21, 2015 at 5:26 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Below is what happens to touchpad on Lenovo Yoga 900 during resume from
> system sleep:

Ok, since my daughter is home for xmas, I can report that it seems to
indeed fix the problem on her Yoga 900 too.

  Reported-and-tested-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

    Linus
