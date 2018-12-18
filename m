From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Documentation: hid: fix wrong data structure reference
 for UHID_OUTPUT
Date: Tue, 18 Dec 2018 14:55:48 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1812181455400.17216@cbobk.fhfr.pm>
References: <20181213012851.GA25516@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213012851.GA25516@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 13 Dec 2018, Peter Hutterer wrote:

> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  Documentation/hid/uhid.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
> index c8656dd029a9..958fff945304 100644
> --- a/Documentation/hid/uhid.txt
> +++ b/Documentation/hid/uhid.txt
> @@ -160,7 +160,7 @@ them but you should handle them according to your needs.
>    UHID_OUTPUT:
>    This is sent if the HID device driver wants to send raw data to the I/O
>    device on the interrupt channel. You should read the payload and forward it to
> -  the device. The payload is of type "struct uhid_data_req".
> +  the device. The payload is of type "struct uhid_output_req".
>    This may be received even though you haven't received UHID_OPEN, yet.

Applied, thanks Peter.

-- 
Jiri Kosina
SUSE Labs
