From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Tue, 23 Oct 2007 23:33:08 -0400
Message-ID: <200710232333.08306.dmitry.torokhov@gmail.com>
References: <20070609084800.GR6362@aehallh.com> <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com> <1193191094.32696.2.camel@moonpix.desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1193191094.32696.2.camel@moonpix.desrt.ca>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Ryan Lortie <desrt@desrt.ca>
Cc: "Zephaniah E. Hull" <warp@aehallh.com>, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Tuesday 23 October 2007, Ryan Lortie wrote:
> On Tue, 2007-23-10 at 14:10 -0400, Dmitry Torokhov wrote:
> > No, rfkill want to see keypresses, period. It does not care if there
> > are other applications also seeing the same keypresses, it just does
> > not want keypresses stolen from it.
> 
> Right.  This is exactly the problem.  The current grab API exists to
> prevent keys from being delivered to normal users, but rfkill still
> wants to see them.
> 
> No matter how you slice it, if both of these desires are to be satisfied
> then there needs to be some sort of a system to differentiate between
> rfkill and "normal users".  That's what the priority is here.
> 

And the solution is pretty simple - do not use grab.

-- 
Dmitry
