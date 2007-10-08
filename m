From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Handling transition into suspend through keyboard driver
Date: Mon, 8 Oct 2007 00:25:10 -0700
Message-ID: <20071008002510.d3ce4591.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry <dmitry.torokhov@gmail.com>
Cc: linux-input-list <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Greetings,

Dmitry, Im implementing suspend for hp7xx currently. I've added EV_PWR to bitflags and linked so POWER_KEY gets reported correctly.
Is this the correct approach?

I want to make use of the generic pm code that exists for sa1100.

I know this is abit of your speciality but had a hard time finding examples.

Best wishes
Kristoffer Ericson
