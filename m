From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Drivers:input:mousedev.c: Fixed trailing statement on
 the next line
Date: Sat, 29 Nov 2014 09:54:41 -0800
Message-ID: <1417283681.818.1.camel@perches.com>
References: <1417278043-4870-1-git-send-email-athirasnamby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:50368 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751339AbaK2Ryp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Nov 2014 12:54:45 -0500
In-Reply-To: <1417278043-4870-1-git-send-email-athirasnamby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Athira S <athirasnamby@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2014-11-29 at 21:50 +0530, Athira S wrote:
> Fixed checkpatch error:
> trailing statements should be on next line
> 
> signed-off-by: Athira S <athirasnamby@gmail.com>
> ---
>  drivers/input/mousedev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> index be2cc5c..28988f5 100644
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -248,8 +248,8 @@ static void mousedev_key_event(struct mousedev *mousedev,
>  	case BTN_4:
>  	case BTN_EXTRA:		index = 4; break;
>  
> -	default:
> -	return;
> +	default:	
> +				return;

Please run your suggested patches though
scripts/checkpatch.pl before sending them.

Don't send patches on top of your own
unapplied patches.  Use the original and
create a new patch.

Probably none of this needs to be changed.


