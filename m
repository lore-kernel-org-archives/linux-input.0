From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] HID: i2c-hid: fix race condition reading reports
Date: Mon, 17 Nov 2014 13:51:11 -0800
Message-ID: <20141117215111.GA19828@kroah.com>
References: <1416149064-25655-1-git-send-email-borneo.antonio@gmail.com>
 <20141117214305.GC30324@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141117214305.GC30324@mail.corp.redhat.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 17, 2014 at 04:43:05PM -0500, Benjamin Tissoires wrote:
> Hey Antonio,
> 
> On Nov 16 2014 or thereabouts, Antonio Borneo wrote:
> > From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > 
> > From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > 
> > Current driver uses a common buffer for reading reports either
> > synchronously in i2c_hid_get_raw_report() and asynchronously in
> > the interrupt handler.
> > There is race condition if an interrupt arrives immediately after
> > the report is received in i2c_hid_get_raw_report(); the common
> > buffer is modified by the interrupt handler with the new report
> > and then i2c_hid_get_raw_report() proceed using wrong data.
> > 
> > Fix it by using a separate buffers for asynchronous reports.
> > 
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > [Antonio Borneo: cleanup and rebase to v3.17]
> > Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> For your next submission, when you want a patch to go in stable, put CC
> here, but please do not CC the actual mail to stable@. Stable should receive
> either mails which are already in Linus' tree, or which refer a commit
> in Linus' tree in case it does not applies smoothly.
> 
> [keeping stable@ here to show them that this one should not get picked
> right now]

stable@ is smarter than that, I don't mind seeing patches that are
coming in the future like this at all, it's not a problem.

thanks,

greg k-h
