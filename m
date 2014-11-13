From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Thu, 13 Nov 2014 14:15:11 -0800
Message-ID: <CANLzEksHgo_tQiwJoUtXd0iV7tDXq0ieNrAXgtXwPtxxPBWrgw@mail.gmail.com>
References: <CANLzEktsBvmX7Nbn=+JBq6A=cowqnFVPJ1ymQjbv4dgrDvSLFA@mail.gmail.com>
	<Pine.LNX.4.44L0.1411131710200.4266-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1411131710200.4266-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Alan,

On Thu, Nov 13, 2014 at 2:11 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> Wait a minute -- in your previous email you said this approach didn't
> work.  So does it work or doesn't it?

Sorry for the confusion. The approach *does* work.

That was actually my original idea to fix the problem, but I saw other
places in the kernel where it was done with a get/put.


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
