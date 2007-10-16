From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Power button policy and mechanism
Date: Tue, 16 Oct 2007 13:40:50 -0700
Message-ID: <20071016134050.f7106efe.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry <dtor@insightbb.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-main <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Greetings Dmitry,

Is the suggested approach on handling powerbutton (in keyboard driver) to simply push out the event and let userland handle it? 
The reason Im asking this is because as you might know Im maintainer for two mini-laptop style pda's (HP7xx & HP6xx)
and it would simplify my life alot if I didn't need to depend on userland applications to be able to suspend/resume.

For instance HP6XX receives an interrupt call whenever the powerbutton is pressed. Now I could just push out the event and let another program handle it but considering it would take a minimum amount of lines to let it simply suspend/resume I feel its a waste.

Previously the hp6xx has been allowed to do this "policy" way but that was when LinuxSH stod as a side branch to main tree. Now
when everything gets merged into mainline I need to decide how to do this.

This is mainly an embedded issue, but I feel it's quite important. It should apply to other devices also like for example Zaurus branches (those with keyboard and designated power button).

So in short:
1. Does mainline policy allow static power button events inside kernel (power button == suspend/resume)?
	Why/Why Not?
2. Seeing as my knowledge about this area isn't the best I would appreciate all opinions on the subject from the gurus.

Best wishes
Kristoffer Ericson

-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
