From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] hid: hidpidff: Use pr_<level>
Date: Tue, 23 Nov 2010 13:36:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231336420.18801@pobox.suse.cz>
References: <1290497701.28824.6.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290497701.28824.6.camel@Joe-Laptop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 22 Nov 2010, Joe Perches wrote:

> Prefixes were not standardized in this module.
> Some used "hid-pidff:", others "hidpidff:".
> Add pr_fmt(fmt) KBUILD_MODNAME ": " fmt to standardize prefix uses.

Hmm, how about using dev_dbg instead? So that we get the bonus of having 
the device name there for free?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
