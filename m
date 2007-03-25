From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Circular synaptics pads
Date: Sun, 25 Mar 2007 10:46:20 -0400
Message-ID: <200703251046.20670.dtor@insightbb.com>
References: <20070324042708.GA14593@srcf.ucam.org> <200703250127.35272.dtor@insightbb.com> <20070325142912.GA2938@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070325142912.GA2938@srcf.ucam.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sunday 25 March 2007 10:29, Matthew Garrett wrote:
> On Sun, Mar 25, 2007 at 01:27:34AM -0400, Dmitry Torokhov wrote:
> 
> > Would something like below do (untested)?
> 
> Looks good to me.
> 
> > +	 * input device->id.verssion and be visible to userspace.
> 
> id.version rather than id.verssion?
> 

Yep, thanks for spotting. I am terrible with typos in comments.

-- 
Dmitry
