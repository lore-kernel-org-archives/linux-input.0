From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Date: Fri, 18 Feb 2011 09:45:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it> <id3cua$12v$2@dough.gmane.org> <20110217151931.d7ee7e29.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110217151931.d7ee7e29.ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: "pascal-dXI0m6hRz7k@public.gmane.org" <pascal-dXI0m6hRz7k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 17 Feb 2011, Antonio Ospite wrote:

> However, even if my patch gets is, Output reports on the Sixaxis will
> stop working again as soon as someone implements the behavior you are
> suggesting, that is:
>   Feature Report -> SET_REPORT on the Control channel
>   Output Report  -> DATA on the Interrupt channel
> 
> So I am going to submit the hidp_output_raw_report() override in
> hid-sony.c as well, does this sound OK?

That makes sense to me.

Could you please repost all the patches that are currently being discussed 
are flying around in the air?

I feel I haven't been CCed on all of them, so I don't have the complete 
picture.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
