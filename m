From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move gameports out of SERIO menu
Date: Tue, 2 Oct 2007 17:38:11 -0400
Message-ID: <200710021738.11349.dmitry.torokhov@gmail.com>
References: <20071002141225.d503cdbb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071002141225.d503cdbb.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, akpm <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

Hi Randy,

On Tuesday 02 October 2007, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Move the gameport support menu out of the SERIO menu and put it
> between touchscreens and misc. devices in the main input layer menu.
> Change it to use menuconfig instead of config.
> 
> Or was it meant to be listed under Hardware I/O ports?
> It sure seems odd there to me.

Yes, they are meant to be under "Hardware I/O" ports. Like serio ports
they represent hardware ports to which devices (such as gamepads or
a joysticks can be connected to).

-- 
Dmitry
