From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Input: atkbd - Add force relese key quirk for HP ProBook
Date: Tue, 28 Feb 2012 16:46:04 -0800
Message-ID: <20120229004604.GB21093@kroah.com>
References: <1330475770-4153-1-git-send-email-manoj.iyer@canonical.com>
 <1330475770-4153-2-git-send-email-manoj.iyer@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1330475770-4153-2-git-send-email-manoj.iyer@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 28, 2012 at 06:36:10PM -0600, Manoj Iyer wrote:
> HP ProBooks do not send a key release for brightness keys, as a
> result, brightness does not move up/down when the brightness key
> is held down. This quirk makes the brightness keys on HP ProBooks
> typematic.
> 
> Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> ---
>  drivers/input/keyboard/atkbd.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
