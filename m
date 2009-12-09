From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Wed, 9 Dec 2009 20:16:20 +0000
Message-ID: <20091209201620.GA25133@srcf.ucam.org>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com> <20091209200614.GA10138@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091209200614.GA10138@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 09, 2009 at 12:06:15PM -0800, Dmitry Torokhov wrote:

> This is certainly going in the direction I wanted but it looks like
> it is more complex than it needs to be. Why don't you just allow
> installing global filter for entire i8042 (pass the status register
> there along with data byte)? The data you are interested in goes kind of
> "ouside" KBD/AUX port abstraction anyway...  Plus currently you are not
> handling MUX case properly.

Wouldn't that require me to be able to process any conceivable mouse 
protocol as well?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
