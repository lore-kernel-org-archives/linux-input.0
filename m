From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: update documentation for EVIOCGMASK/EVIOCSMASK
Date: Thu, 21 Apr 2016 10:09:11 +0200
Message-ID: <CANq1E4RD2PF9amHO1q=yXMeqdbcsfpDyMXU9i3jCs5eubhfdGg@mail.gmail.com>
References: <20160421031826.GA6719@jelly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38643 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcDUIJM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 04:09:12 -0400
Received: by mail-wm0-f46.google.com with SMTP id u206so118647968wme.1
        for <linux-input@vger.kernel.org>; Thu, 21 Apr 2016 01:09:12 -0700 (PDT)
In-Reply-To: <20160421031826.GA6719@jelly.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Thu, Apr 21, 2016 at 5:18 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> The current implementation does not match the most intuitive reading of the
> documentation. The documentation suggests that anything after FOO_CNT would
> be reset to zeroes. The implementation however works on long boundaries
> instead.
>
> For example, a client requesting the EV_REL mask will see the first 64 bits
> set to one in the default mask, everything else is zero. Setting a mask will
> apply the mask for the first 64 bits, the others are cleared.
>
> There are few use-cases where this actually matters to a client - if a
> device doesn't have the event code anyway the mask doesn't matter. So change
> two absolute statements to a "may" to indicate that bits may or may not be
> set.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  include/uapi/linux/input.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks!
David

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 0111384..6069524 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -181,7 +181,7 @@ struct input_mask {
>   * The default event mask for a client has all bits set, i.e. all events
>   * are forwarded to the client. If the kernel is queried for an unknown
>   * event type or if the receive buffer is larger than the number of
> - * event codes known to the kernel, the kernel returns all zeroes for those
> + * event codes known to the kernel, the kernel may return zeroes for those
>   * codes.
>   *
>   * At maximum, codes_size bytes are copied.
> @@ -204,7 +204,7 @@ struct input_mask {
>   * is unknown to the kernel, or if the number of event codes specified in
>   * the mask is bigger than what is known to the kernel, the ioctl is still
>   * accepted and applied. However, any unknown codes are left untouched and
> - * stay cleared. That means, the kernel always filters unknown codes
> + * may be cleared. That means, the kernel always filters unknown codes
>   * regardless of what the client requests.  If the new mask doesn't cover
>   * all known event-codes, all remaining codes are automatically cleared and
>   * thus filtered.
> --
> 2.7.3
>
