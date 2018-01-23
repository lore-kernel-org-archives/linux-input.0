From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Tue, 23 Jan 2018 15:40:21 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231540110.11852@cbobk.fhfr.pm>
References: <20171204205550.2621-1-tk@the-tk.com> <20171219204436.27737-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171219204436.27737-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, =?ISO-8859-15?Q?Diego_Elio_Petten=F2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 19 Dec 2017, Tomasz Kramkowski wrote:

> This patch rewrites the mouse report fixup used for the DEFT and HUGE
> elecom trackballs in order to make it generic enough to fix other
> elecom mice with similar issues. This patch also uses this new report
> fixup function to fix the Elecom EX-G trackball which has 6 physical
> buttons and a similar issue to the other two mice.
> 
> Elecom's track record has so far shown that they like to re-use the
> same report descriptor for multiple different mice regardless of the
> number of buttons the mouse has. This means that the missing buttons
> on multiple mice can be fixed in one function without introducing
> phantom buttons which would in turn cause the number of mouse buttons
> to be misreported to userspace.
> 
> This patch drops the very verbose report descriptor "diff" comment for
> a more abridged yet hopefully just as informative generic version.
> 
> Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
> ---
> v2 changes:
> * pass rsize directly to mouse_button_fixup
> * add support for wireless EX-G variant
> v1: https://marc.info/?i=20171204205550.2621-1-tk@the-tk.com

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
