From: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers/hid: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 11:06:56 -0700
Message-ID: <CAGXu5jL3ou=ipy+aH1vtD659T7HZW6=YXU_xN_CZyf-i4-wq5w@mail.gmail.com>
References: <1508867719-16157-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1508867719-16157-1-git-send-email-allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 24, 2017 at 10:55 AM, Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> Switch to using the new timer_setup() and from_timer()
> for drivers/hid/*
>
> Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Yup, this matches what I'd expect for timer_setup() conversion in
these files, thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
