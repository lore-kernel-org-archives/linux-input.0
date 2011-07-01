From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Fri, 01 Jul 2011 10:08:36 +0100
Message-ID: <4E0D8E94.5030604@cam.ac.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Royer <nroyer@invensense.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/01/11 03:18, Nathan Royer wrote:
> This files defines the userspace interface and how to integrate it into a
> platform.
> 
> Signed-off-by: Nathan Royer <nroyer@invensense.com>
> ---
> 
> This is the first of many patch files for the inv_mpu driver in its current
> state.  This is our first time submitting this driver, so I expect there to be
> a lot wrong with it, and expect to need to fix many things.
Just out of interest, can you give details of what other patches are to come?
I'm guessing more sensor drivers and I hate discovering I'm implementing drivers
for devices that someone already has working code for!
