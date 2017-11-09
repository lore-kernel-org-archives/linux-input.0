From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] HID: cp2112: fix interface specification URL
Date: Thu, 9 Nov 2017 12:45:30 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091245160.32604@cbobk.fhfr.pm>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Julien Boibessot <julien.boibessot@armadeus.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2 Nov 2017, Sébastien Szymanski wrote:

> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  drivers/hid/hid-cp2112.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 078026f..28e3c18 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -21,7 +21,7 @@
>   * Data Sheet:
>   *   http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf
>   * Programming Interface Specification:
> - *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
> + *   https://www.silabs.com/documents/public/application-notes/an495-cp2112-interface-specification.pdf
>   */

I've applied patches 1 and 2 (with stable anotation) for now. Thanks,

-- 
Jiri Kosina
SUSE Labs
