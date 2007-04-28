From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Enabling/disabling input events.
Date: Sat, 28 Apr 2007 09:05:54 -0400
Message-ID: <200704280905.55076.dtor@insightbb.com>
References: <20070425172454.GD4831@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070425172454.GD4831@aehallh.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: devel@laptop.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

On Wednesday 25 April 2007 13:24, Zephaniah E. Hull wrote:
> The current trend is for events like power buttons and lid switches to
> be handled through the input subsystem.
> 
> This leaves an odd hole for cases where you wish to set the hardware
> behavior of these buttons, specificly on the OLPC we have several events
> that signal through the input system, which are capable of waking the
> system from suspend mode.  This is not always desirable, so the
> hardware leaves us a way to disable the button/switch completely, but at
> the moment there is no clean kernel interface for this.
>

Input layer (with the exception of keyboard repeat rate) presently
does not control underlying hardware, this task is left to individual
drivers. For example atkbd is responsible for changing keyboard set,
psmouse is responsible for setting desired report rate and resolution,
control various quirks of IBM trackpoint devices, etc. etc. There are
unlimited number of knobs that may be needed for various devices that
it is impossible to come up with standard interface.

I think enabling/disabling wakeup events belongs with the rest of
knobs in PM (ACPI?) subsystem.

-- 
Dmitry
