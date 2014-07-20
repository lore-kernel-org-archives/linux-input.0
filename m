From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] Input: fix defuzzing logic
Date: Sun, 20 Jul 2014 20:19:23 +0200
Message-ID: <53CC082B.70207@euromail.se>
References: <20140719234843.GA28580@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140719234843.GA28580@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, David Herrmann <dh.herrmann@gmail.com>, Andrew de los Reyes <adlr@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> We attempt to remove noise from coordinates reported by devices in
> input_handle_abs_event(), unfortunately, unless we were dropping the
> event altogether, we were ignoring the adjusted value and were passing
> on the original value instead.
> 
> Reviewed-by: Andrew de los Reyes <adlr@chromium.org>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/input.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Oh my, that was a bad one.

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
