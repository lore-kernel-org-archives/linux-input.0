From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Getting touchscreen to work on Fujitsu B6210
Date: Wed, 21 Feb 2007 22:16:29 -0800
Message-ID: <20070221221629.59088fed@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

I did a little investigation and the touchscreen on B6210 is
attached via the 8250 serial port. I tried enabling it with
inputattach but seem to get garbage.

I can extract the initialization code from the evtouch driver
to a usermode program and read information from /dev/ttyS0.

The lifebook psmouse extension won't work because it tries
to grab the 8042 (touchpad) rather than the touch screen.

Ideas?
