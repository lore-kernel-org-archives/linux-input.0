From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2 3/4] psmouse: Disable resolution/rate/scale changes for
 FocalTech touchpads.
Date: Sat, 7 Mar 2015 20:14:34 -0800
Message-ID: <20150308041434.GA1482@dtor-ws>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-4-git-send-email-mgottschlag@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34041 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbCHEOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2015 23:14:39 -0500
Content-Disposition: inline
In-Reply-To: <1424992808-29891-4-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mathias,

On Fri, Feb 27, 2015 at 12:20:07AM +0100, Mathias Gottschlag wrote:
> These PS/2 commands make some touchpads stop responding, so this commit
> adds some dummy functions to replace the generic implementation. Because
> @@ -60,6 +65,7 @@ struct psmouse {
>  
>  	unsigned int rate;
>  	unsigned int resolution;
> +	enum psmouse_scale scale;
>  	unsigned int resetafter;
>  	unsigned int resync_time;
>  	bool smartscroll;	/* Logitech only */

I do not believe we need to store the scaling factor so I dropped these
chunks, otherwise applied all 4.

Thanks.

-- 
Dmitry
