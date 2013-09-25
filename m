From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] hid-elo: some systems cannot stomach work around
Date: Wed, 25 Sep 2013 11:29:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309251129170.18703@pobox.suse.cz>
References: <1380094975-4481-1-git-send-email-oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380094975-4481-1-git-send-email-oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 25 Sep 2013, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org wrote:

> Some systems although they have firmware class 'M', which usually
> needs a work around to not crash, must not be subjected to the
> work around because the work around crashes them. They cannot be
> told apart by their own device descriptor, but as they are part
> of compound devices, can be identified by looking at their siblings.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
