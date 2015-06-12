From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: Add generic driver for Zeitec touchscreens
Date: Thu, 11 Jun 2015 17:45:18 -0700
Message-ID: <20150612004518.GE20581@dtor-pixel>
References: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
 <20150530001414.GD7429@dtor-ws>
 <CAEm+DGVPNqWQOP_Tu4ae=pua6N5nC0Q+TkUCDB8tKzaX43iYNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEm+DGVPNqWQOP_Tu4ae=pua6N5nC0Q+TkUCDB8tKzaX43iYNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan George Stefan <bogdan.george.stefan@gmail.com>
Cc: Bogdan George Stefan <bogdan.g.stefan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Purdila Octavian <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

Hi Bogdan,

On Tue, Jun 02, 2015 at 10:43:01AM +0300, Bogdan George Stefan wrote:
> Dimitry,
> 
> I know 0xB2 should provide that information according to the
> datasheet, however here is what Zeitec guys had to say when I asked
> them why it does not work:
> 
> "0xB2 is deprecated.
> It only supports in Zet6221/31 serious but zet9172/zet6273."
> 
> If you like, I can attach my conversation with them.
>

Not really, but I would like to understand how the part selection works.
Are they the same parts or different parts? Let's say you want to build
a system and you want part that reports up to 7 contacts. How do you
communicate this to the supplier? The number of contacts - is it
controller by the config file you load into the controller, or they have
separate parts for different contact count or what?

Thanks.

-- 
Dmitry
