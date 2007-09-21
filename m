From: Oliver Neukum <oliver@neukum.org>
Subject: detecting when keys are being pressed on a keyboard
Date: Fri, 21 Sep 2007 10:33:09 +0200
Message-ID: <200709211033.09698.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Hi,

I got the strange case of a keyboard going into autosuspend while a key
was being pressed. The key release never arrived and I had to unplug
the keyboard to get the key unstuck. Is there a clean way to learn from
hid-core.c if a keyboard has keys pressed?

	Regards
		Oliver
