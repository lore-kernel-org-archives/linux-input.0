From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] Input: matrix-keypad - support binary column select gpios
Date: Thu, 21 Feb 2013 07:41:51 +0000
Message-ID: <CACxGe6s8DfU7ahE2nOK+UxqDq06vogADZgoqXPUKBoBaxwoigQ@mail.gmail.com>
References: <1359462324-7233-1-git-send-email-agust@denx.de> <1361388475-23705-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37737 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3BUHmO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2013 02:42:14 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so11037844iec.18
        for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 23:42:13 -0800 (PST)
In-Reply-To: <1361388475-23705-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Feb 20, 2013 at 7:27 PM, Anatolij Gustschin <agust@denx.de> wrote:
> On hardware with limited gpios one column select gpio can select
> two different rows when using some additional hardware logic:
> high value selects one row, low value selects another row. Add
> support for such matrix keyboards and document device tree
> bindings used to describe them.
>
> Since half of the columns is always not selected, interrupts won't be
> generated for press events on these columns. To generate interrupts
> for not selected columns we need to periodicaly switch to these columns
> in order to catch the potential press events. This is done by additional
> work function.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> v2:
>  - do not use inline attribute for matrix_keyboard_row_events(),
>    it causes reporting wrong events for some keys if the kernel
>    was built using gcc 4.7.2.
>
>  .../bindings/input/gpio-matrix-keypad.txt          |    7 ++
>  drivers/input/keyboard/matrix_keypad.c             |  112 ++++++++++++++++----
>  include/linux/input/matrix_keypad.h                |    6 +
>  3 files changed, 106 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> index ead641c..57f4be3 100644
> --- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> @@ -23,6 +23,13 @@ Optional Properties:
>  - debounce-delay-ms:   debounce interval in milliseconds
>  - col-scan-delay-us:   delay, measured in microseconds, that is needed
>                         before we can scan keypad after activating column gpio
> +- col-gpios-binary:    specify that high and low states of a column gpio
> +                       select two different rows (boards with limited gpios
> +                       could support this by additional hardware logic)
> +- col-switch-delay-ms: column gpio switch interval for selecting alternative
> +                       rows when using 'col-gpios-binary'. This is needed for
> +                       periodical selecting of the alternative rows to be able
> +                       to generate keypad interrupts for them

This seems pretty loosely defined. Which rows are affected by this
binary property? How common are matrix keypads wired this way, and do
a lot of them use the same method? It seems to me that the device
needs to be a lot more specific.

g.
