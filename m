From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] input: matrix_keypad: add option to drive inactive
 columns
Date: Tue, 28 Mar 2017 21:02:29 -0500
Message-ID: <20170329020229.dm3y57dlzjwilifm@rob-hp-laptop>
References: <20170322201650.9072-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322201650.9072-1-drivshin-WHIoityCHfoAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Rivshin <drivshin-WHIoityCHfoAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 22, 2017 at 04:16:50PM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>
> 
> The gpio-matrix-keypad driver normally sets inactive columns as inputs
> while scanning. This does not work for all hardware, which may require
> the inactive columns to be actively driven in order to overcome any
> pull-ups/downs on the columns.
> 
> Signed-off-by: David Rivshin <drivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/input/gpio-matrix-keypad.txt        |  2 ++
>  drivers/input/keyboard/matrix_keypad.c                      | 13 +++++++++----
>  include/linux/input/matrix_keypad.h                         |  3 +++
>  3 files changed, 14 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
