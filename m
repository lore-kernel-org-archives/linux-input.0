From: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Tue, 04 Nov 2008 21:34:43 +0100
Message-ID: <4910B1E3.8090908@gmail.com>
References: <200811031731.38055.oliver@neukum.org> <200811041629.39945.oliver@neukum.org> <49106B5D.5020701@gmail.com> <200811041856.47950.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811041856.47950.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Oliver Neukum napsal(a):
> Am Dienstag, 4. November 2008 16:33:49 schrieb Jiri Slaby:
>> Oliver Neukum napsal(a):
>>> Yes, I see. However, the device must not be registered before the table
>>> is correctly filled and the minor must be filled out before. A mutex then?
>> It's enough to assign the hiddev_table after the register, isn't it?
>> Actually, it's how it's done now... BTW what was the reason to move with that?
> 
> No, you have a race condition where open() for an announced device
> will fail.

Could you expand this? I don't understand.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
