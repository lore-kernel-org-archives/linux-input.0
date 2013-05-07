From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lenovo Yoga 13 touchpad regression
Date: Tue, 07 May 2013 16:19:31 -0700
Message-ID: <3470196.LXVkxnnbGR@dtor-d630.eng.vmware.com>
References: <5188905A.4020703@zytor.com> <51894B6F.9040108@zytor.com> <51898810.4090301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51898810.4090301@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, May 07, 2013 04:02:40 PM H. Peter Anvin wrote:
> On 05/07/2013 11:43 AM, H. Peter Anvin wrote:
> > What is really bizarre is that some time today the touchpad
> > spontaneously started to work.  However, after a reboot it no longer
> > worked again.  This is on 3.8.11.  The keycode spewage continued, however.
> 
> OK, "spontaneously" seems to mean "after going in and out of suspend to
> RAM".

Does i8042.reset help by any chance?

-- 
Dmitry
