From: Roger Dahl <rogerdahl@dahlsys.com>
Subject: USB remote control
Date: Thu, 22 Mar 2007 12:05:43 -0600
Message-ID: <4602C577.8090207@dahlsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello everyone,

I have a remote control that looks like a USB keyboard to the system. 
When I press buttons on the remote, key presses appear in X and the VTs. 
I would like to change my configuration so that events from the remote 
don't turn into key presses and become available only in 
/dev/input/eventN (where I will read them with a custom application).

I'm running FC6. Any help or pointers on how to accomplish this would be 
much appreciated.

Thank you,

Roger
