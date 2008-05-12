From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 9/9] HID: add compat support
Date: Mon, 12 May 2008 09:19:28 +0200
Message-ID: <4827EF80.7070404@gmail.com>
References: <1210536043-19812-2-git-send-email-jirislaby@gmail.com> <1210536043-19812-3-git-send-email-jirislaby@gmail.com> <1210536043-19812-4-git-send-email-jirislaby@gmail.com> <1210536043-19812-5-git-send-email-jirislaby@gmail.com> <1210536043-19812-6-git-send-email-jirislaby@gmail.com> <1210536043-19812-7-git-send-email-jirislaby@gmail.com> <1210536043-19812-8-git-send-email-jirislaby@gmail.com> <1210536043-19812-9-git-send-email-jirislaby@gmail.com> <20080511204807.GB850@uranus.ravnborg.org> <48275FFC.9060305@gmail.com> <20080511211839.GA1641@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760458AbYELHUH@vger.kernel.org>
In-Reply-To: <20080511211839.GA1641@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On 05/11/2008 11:18 PM, Sam Ravnborg wrote:
> So what I try to say is that we should replace the above with
> a hid-dummy.h file that is handedited.

Ah, yes, I got it now. I mulled over that, we're talking about 15 or so drivers 
and it's pretty ugly. I'll drop hid-dummy.h file generation, since it will be no 
longer needed.

> We could stick a few comments in the .h file explaining the usage too.

I think it's not worth it. It's just for 2, 3 kernel releases and then we will
say it goodbye.

Thanks.
