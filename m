From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 3/4] liss331d1: accelerometer driver
Date: Thu, 15 Apr 2010 21:12:27 +0200
Message-ID: <20100415191227.GA1559@ucw.cz>
References: <20100414124913.23181.75903.stgit@localhost.localdomain> <20100414125155.23181.56610.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100414125155.23181.56610.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed 2010-04-14 13:52:00, Alan Cox wrote:
> From: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The acceleremeter driver reads the x,y,z coordinate registers and provides
> the information to user through the input layer
> 
> Conversion to input device, clean up and porting of retry fixes needed
> for AAVA done by Alan Cox.

Out of interest, what is AAVA?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
