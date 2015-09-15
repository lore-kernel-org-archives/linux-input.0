From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] Input: mms114 - remove unneded semicolons
Date: Tue, 15 Sep 2015 09:09:42 +0900
Message-ID: <55F761C6.1090805@samsung.com>
References: <1442234638-31460-1-git-send-email-javier@osg.samsung.com>
 <1442234638-31460-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442234638-31460-2-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 14.09.2015 21:43, Javier Martinez Canillas wrote:
> They aren't needed and are just creating null statements so remove it.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/input/touchscreen/mms114.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch is obvious (actually it could go to trivial tree), so FWIW:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
