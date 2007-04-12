From: Pete Zaitcev <zaitcev@redhat.com>
Subject: One odd thing about Synaptics
Date: Wed, 11 Apr 2007 17:17:49 -0700
Message-ID: <20070411171749.2337d620.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: petero2@telia.com
Cc: dtor@insightbb.com, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi, Peter:

There's one thing I wanted to report, just in case... It does not affect
anything, but it's odd.

Every time I lift a finger from the pad, the driver sends an event with
odd values (X is 1 and Y is 5855):

Event: time 1174695694.561806, type 1 (Key), code 330 (Touch), value 0
Event: time 1174695694.561809, type 3 (Absolute), code 0 (X), value 1425
Event: time 1174695694.561811, type 3 (Absolute), code 1 (Y), value 1223
Event: time 1174695694.561813, type 3 (Absolute), code 24 (Pressure), value 20
Event: time 1174695694.561816, -------------- Report Sync ------------
Event: time 1174695694.573918, type 3 (Absolute), code 0 (X), value 1500
Event: time 1174695694.573921, type 3 (Absolute), code 1 (Y), value 1265
Event: time 1174695694.573922, type 3 (Absolute), code 24 (Pressure), value 5
Event: time 1174695694.573924, type 3 (Absolute), code 28 (Tool Width), value 5
Event: time 1174695694.573926, -------------- Report Sync ------------
Event: time 1174695694.585575, type 3 (Absolute), code 0 (X), value 1
Event: time 1174695694.585578, type 3 (Absolute), code 1 (Y), value 5855
Event: time 1174695694.585580, type 3 (Absolute), code 24 (Pressure), value 2
Event: time 1174695694.585582, type 1 (Key), code 325 (ToolFinger), value 0
Event: time 1174695694.585584, type 1 (Key), code 333 (Tool Doubletap), value 1
Event: time 1174695694.585587, -------------- Report Sync ------------
Event: time 1174695694.622685, type 3 (Absolute), code 24 (Pressure), value 1

This correspods to hw.x=1, hw.y=0 in the driver. Looks like a bug somewhere.

Cheers,
-- Pete
