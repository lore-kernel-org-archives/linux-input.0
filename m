From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: reseting an input device due to sleep/resume cycle
Date: Sat, 16 Jun 2007 18:03:21 -0300
Message-ID: <20070616210321.GA17379@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Dmitry, input gurus,

When a ThinkPad does an sleep cycle, the firmware explicitly kills all
pending hotkey state.  That reminds me that I also need to do the same in
thinkpad-acpi.

How does one tell the input layer that it should clear its idea of the
current state of all events in a input device?  I couldn't find any
input_reset() function...

Or is such a reset not needed?  The recent issue with ACPI and EV_SW SW_LID
seems to indicate that in some cases these resets are indeed needed.  For
EV_SW, it appears that I'd have to interate over all my switches and reset
them.  But what about EV_KEY and the others?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
