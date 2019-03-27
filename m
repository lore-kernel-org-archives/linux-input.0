From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ISH firmware loader client driver
Date: Tue, 26 Mar 2019 19:22:09 -0700
Message-ID: <de917efc4ded94b3fbc70913207881b3a0c10b52.camel@linux.intel.com>
References: <1553339772-25012-1-git-send-email-rushikesh.s.kadam@intel.com>
         <31755c704928710da998353192157ddfd903080c.camel@linux.intel.com>
         <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Crews <ncrews@chromium.org>, Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, gwendal@google.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2019-03-26 at 18:39 -0600, Nick Crews wrote:
> Hi Rushikesh, I know I've been reviewing this on Chromium, but I have
> some more larges-scale design thoughts.
Hi Nick.

Does this fundamentally change, the way it is done here or can wait for
subsequent revisions later?

Thanks,
Srinivas

> 
> > > diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> > > b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> > > new file mode 100644
> > > index 0000000..85d71d3
> > > --- /dev/null
> > > +++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> > > @@ -0,0 +1,1103 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ISH-TP client driver for ISH firmware loading
> > > + *
> > > + * Copyright (c) 2018, Intel Corporation.
> > 
> > Year 2019.
> > 
> > > + */
> > > +
> > > +#include <linux/firmware.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/intel-ish-client-if.h>
> > > +#include <linux/property.h>
> > > +#include <asm/cacheflush.h>
> > > +
> > > +/* ISH TX/RX ring buffer pool size */
> > > +#define LOADER_CL_RX_RING_SIZE                       1
> > > +#define LOADER_CL_TX_RING_SIZE                       1
> > > +
> > > +/*
> > > + * ISH Shim firmware loader reserves 4 Kb buffer in SRAM. The
> > > buffer
> > > is
> > > + * used to temporarily hold the data transferred from host to
> > > Shim
> > > firmware
> > > + * loader. Reason for the odd size of 3968 bytes? Each IPC
> > > transfer
> > > is 128
> > > + * bytes (= 4 bytes header + 124 bytes payload). So the 4 Kb
> > > buffer
> > > can
> > > + * hold maximum of 32 IPC transfers, which means we can have a
> > > max
> > > payload
> > > + * of 3968 bytes (= 32 x 124 payload).
> > > + */
> > > +#define LOADER_SHIM_IPC_BUF_SIZE             3968
> > > +
> > > +/**
> > > + * enum ish_loader_commands -        ISH loader host commands.
> > > + * LOADER_CMD_XFER_QUERY     Query the Shim firmware loader for
> > > capabilities
> > > + * LOADER_CMD_XFER_FRAGMENT  Transfer one firmware image
> > > framgment
> > > at a
> > > + *                           time. The command may be executed
> > > multiple
> > > + *                           times until the entire firmware
> > > image
> > > is
> > > + *                           downloaded to SRAM.
> > > + * LOADER_CMD_START          Start executing the main firmware.
> > > + */
> > > +enum ish_loader_commands {
> > > +     LOADER_CMD_XFER_QUERY = 0,
> > > +     LOADER_CMD_XFER_FRAGMENT,
> > > +     LOADER_CMD_START,
> > > +};
> > > +
> > > +/* Command bit mask */
> > > +#define      CMD_MASK                                GENMASK(6,
> > > 0)
> > > +#define      IS_RESPONSE                             BIT(7)
> > > +
> > > +/*
> > > + * ISH firmware max delay for one transmit failure is 1 Hz,
> > > + * and firmware will retry 2 times, so 3 Hz is used for timeout.
> > > + */
> > > +#define ISHTP_SEND_TIMEOUT                   (3 * HZ)
> > > +
> > > +/*
> > > + * Loader transfer modes:
> > > + *
> > > + * LOADER_XFER_MODE_ISHTP mode uses the existing ISH-TP
> > > mechanims to
> > > + * transfer data. This may use IPC or DMA if supported in
> > > firmware.
> > > + * The buffer size is limited to 4 Kb by the IPC/ISH-TP protocol
> > > for
> > > + * both IPC & DMA (legacy).
> > > + *
> > > + * LOADER_XFER_MODE_DIRECT_DMA - firmware loading is a bit
> > > different
> > > + * from the sensor data streaming. Here we download a large
> > > (300+
> > > Kb)
> > > + * image directly to ISH SRAM memory. There is limited benefit
> > > of
> > > + * DMA'ing 300 Kb image in 4 Kb chucks limit. Hence, we
> > > introduce
> > > + * this "direct dma" mode, where we do not use ISH-TP for DMA,
> > > but
> > > + * instead manage the DMA directly in kernel driver and Shim
> > > firmware
> > > + * loader (allocate buf, break in chucks and transfer). This
> > > allows
> > > + * to overcome 4 Kb limit, and optimize the data flow path in
> > > firmware.
> > > + */
> > > +#define LOADER_XFER_MODE_DIRECT_DMA          BIT(0)
> > > +#define LOADER_XFER_MODE_ISHTP                       BIT(1)
> > > +
> > > +/* ISH Transport Loader client unique GUID */
> > > +static const guid_t loader_ishtp_guid =
> > > +     GUID_INIT(0xc804d06a, 0x55bd, 0x4ea7,
> > > +               0xad, 0xed, 0x1e, 0x31, 0x22, 0x8c, 0x76, 0xdc);
> > > +
> > > +#define FILENAME_SIZE                                256
> > > +
> > > +/*
> > > + * The firmware loading latency will be minimum if we can DMA
> > > the
> > > + * entire ISH firmware image in one go. This requires that we
> > > allocate
> > > + * a large DMA buffer in kernel, which could be problematic on
> > > some
> > > + * platforms. So here we limit the DMA buf size via a
> > > module_param.
> > > + * We default to 4 pages, but a customer can set it to higher
> > > limit
> > > if
> > > + * deemed appropriate for his platform.
> > > + */
> > > +static int dma_buf_size_limit = 4 * PAGE_SIZE;
> > > +
> > > +/**
> > > + * struct loader_msg_hdr - Header for ISH Loader commands.
> > > + * @command:         LOADER_CMD* commands. Bit 7 is the
> > > response.
> > > + * @status:          Command response status. Non 0, is error
> > > condition.
> > > + *
> > > + * This structure is used as header for every command/data
> > > sent/received
> > > + * between Host driver and ISH Shim firmware loader.
> > > + */
> > > +struct loader_msg_hdr {
> > > +     u8 command;
> > > +     u8 reserved[2];
> > > +     u8 status;
> > > +} __packed;
> > > +
> > > +struct loader_xfer_query {
> > > +     struct loader_msg_hdr hdr;
> > > +     u32 image_size;
> > > +} __packed;
> > > +
> > > +struct ish_fw_version {
> > > +     u16 major;
> > > +     u16 minor;
> > > +     u16 hotfix;
> > > +     u16 build;
> > > +} __packed;
> > > +
> > > +union loader_version {
> > > +     u32 value;
> > > +     struct {
> > > +             u8 major;
> > > +             u8 minor;
> > > +             u8 hotfix;
> > > +             u8 build;
> > > +     };
> > > +} __packed;
> > > +
> > > +struct loader_capability {
> > > +     u32 max_fw_image_size;
> > > +     u32 xfer_mode;
> > > +     u32 max_dma_buf_size; /* only for dma mode, multiples of
> > > cacheline */
> > > +} __packed;
> > > +
> > > +struct shim_fw_info {
> > > +     struct ish_fw_version ish_fw_version;
> > > +     u32 protocol_version;
> > > +     union loader_version ldr_version;
> > > +     struct loader_capability ldr_capability;
> > > +} __packed;
> > > +
> > > +struct loader_xfer_query_response {
> > > +     struct loader_msg_hdr hdr;
> > > +     struct shim_fw_info fw_info;
> > > +} __packed;
> > > +
> > > +struct loader_xfer_fragment {
> > > +     struct loader_msg_hdr hdr;
> > > +     u32 xfer_mode;
> > > +     u32 offset;
> > > +     u32 size;
> > > +     u32 is_last;
> > > +} __packed;
> > > +
> > > +struct loader_xfer_ipc_fragment {
> > > +     struct loader_xfer_fragment fragment;
> > > +     u8 data[] ____cacheline_aligned; /* variable length payload
> > > here */
> > > +} __packed;
> > > +
> > > +struct loader_xfer_dma_fragment {
> > > +     struct loader_xfer_fragment fragment;
> > > +     u64 ddr_phys_addr;
> > > +} __packed;
> > > +
> > > +struct loader_start {
> > > +     struct loader_msg_hdr hdr;
> > > +} __packed;
> > > +
> > > +/**
> > > + * struct ishtp_cl_data - Encapsulate per ISH-TP Client Data
> > > + * @flag_response    Set true on receiving a firmware  response
> > > to
> > > host
> > > + *                   loader command
> > > + * @cmd_resp_wait:   Wait queue for Host firmware loading, where
> > > the
> > > + *                   client sends message to ISH firmware and
> > > wait
> > > for
> > > + *                   response
> > > + * @work_ishtp_reset:        Work queue for reset handling
> > > + * @work_fw_load:    Work queue for host firmware loading
> > > + * @flag_retry               Flag for indicating host firmware
> > > loading should be
> > > + *                   retried
> > > + * @bad_recv_cnt:    Running count of packets received with
> > > error
> > > + *
> > > + * This structure is used to store data per client
> > > + */
> > > +struct ishtp_cl_data {
> > > +     struct ishtp_cl *loader_ishtp_cl;
> > > +     struct ishtp_cl_device *cl_device;
> > > +
> > > +     /* Completion flags */
> > > +     bool flag_response;
> > > +
> > > +     /* Copy buffer received in firmware "response" here */
> > > +     void *response_data;
> > > +     size_t response_size;
> > > +
> > > +     /* Wait queue for ISH firmware message event */
> > > +     wait_queue_head_t cmd_resp_wait;
> > > +
> > > +     struct work_struct work_ishtp_reset;
> > > +     struct work_struct work_fw_load;
> > > +
> > > +     /*
> > > +      * In certain failure scenrios, it makes sense to reset the
> > > +      * the ISH subsystem and retry Host firmware loading
> > > +      * (e.g. bad message packet, ENOMEM, etc.)
> > > +      * On the other hand, failures due to protocol mismatch,
> > > etc
> > > +      * are not recoverable. We do not retry.
> > > +      *
> > > +      * If set, the flag indictes that we should re-try the
> > > particular
> > > +      * failure.
> > > +      */
> > > +     bool flag_retry;
> > > +
> > > +     /* Statistics */
> > > +     unsigned int bad_recv_cnt;
> > > +};
> > > +
> > > +#define IPC_FRAGMENT_DATA_PREAMBLE                           \
> > > +     offsetof(struct loader_xfer_ipc_fragment, data)
> > > +
> > > +#define cl_data_to_dev(client_data) ishtp_device((client_data)-
> > > > cl_device)
> > > 
> > > +
> > > +/**
> > > + * get_firmware_variant() - Gets the filename of firmware image
> > > to
> > > be
> > > + *                   loaded based on platform variant.
> > > + * @client_data              Client data instance.
> > > + * @filename         Returns firmware filename.
> > > + *
> > > + * Queries the firmware-name device property string.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int get_firmware_variant(struct ishtp_cl_data
> > > *client_data,
> > > +                             char *filename)
> > > +{
> > > +     int rv;
> > > +     const char *val;
> > > +     struct device *devc = ishtp_get_pci_device(client_data-
> > > > cl_device);
> > > 
> > > +
> > > +     rv = device_property_read_string(devc, "firmware-name",
> > > &val);
> > > +     if (rv < 0) {
> > > +             dev_err(devc,
> > > +                     "Error: ISH firmware-name device property
> > > required\n");
> > > +             return rv;
> > > +     }
> > > +     return snprintf(filename, FILENAME_SIZE, "intel/%s", val);
> > > +}
> > > +
> > > +/**
> > > + * report_bad_packets() Report bad packets
> > > + * @loader_ishtp_cl: Client instance to get stats
> > > + * @recv_buf:                Raw received host interface message
> > > + *
> > > + * Dumps error in case bad packet is received
> > > + */
> > > +static void report_bad_packet(struct ishtp_cl *loader_ishtp_cl,
> > > +                           void *recv_buf)
> > > +{
> > > +     struct loader_msg_hdr *hdr = recv_buf;
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     client_data->bad_recv_cnt++;
> > > +     dev_err(cl_data_to_dev(client_data),
> > > +             "BAD packet: command=%02lx is_response=%u
> > > status=%02x
> > > total_bad=%u\n",
> > > +             hdr->command & CMD_MASK,
> > > +             hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             hdr->status,
> > > +             client_data->bad_recv_cnt);
> > > +}
> 
> I would remove this function. Whenever you call it, you already have
> use dev_err() to print the reason for the error. Consider removing
> bad_rcv_count too unless you do something with it other than
> debugging.
> 
> At the very least, you call this function when the ISH doesn't return
> enough
> data, but in here you try to access the fields in hdr. This could be
> accessing
> irrelevant/illegal data.
> 
> Also a nit: The docstring function name has a naughty trailing s.
> 
> > > +
> > > +/**
> > > + * loader_ish_hw_reset() - Reset ISH HW in bad state
> > > + * @loader_ishtp_cl  Client instance to reset
> > > + *
> > > + * This function resets ISH hardware, which shall reload
> > > + * the Shim firmware loader, initiate ISH-TP interface reset,
> > > + * re-attach kernel loader driver, and repeat Host
> > > + * firmware load.
> > > + */
> > > +static inline void loader_ish_hw_reset(struct ishtp_cl
> > > *loader_ishtp_cl)
> > > +{
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     dev_warn(cl_data_to_dev(client_data), "Reset the ISH
> > > subsystem\n");
> > > +     ish_hw_reset(ishtp_get_ishtp_device(loader_ishtp_cl));
> > > +}
> 
> Delete this as a function. Before you actually called it in multiple
> places,
> but now i's only called in one place, so just inline it there.
> 
> > > +
> > > +/**
> > > + * loader_cl_send()  Send message from host to firmware
> > > + * @client_data:     Client data instance
> > > + * @msg                      Message buffer to send
> > > + * @msg_size         Size of message
> > > + *
> > > + * Return: Received buffer size on success, negative error code
> > > on
> > > failure.
> > > + */
> > > +static int loader_cl_send(struct ishtp_cl_data *client_data,
> > > +                       u8 *msg, size_t msg_size)
> > > +{
> > > +     int rv;
> > > +     size_t data_len;
> > > +     struct loader_msg_hdr *in_hdr;
> > > +     struct loader_msg_hdr *out_hdr = (struct loader_msg_hdr
> > > *)msg;
> > > +     struct ishtp_cl *loader_ishtp_cl = client_data-
> > > > loader_ishtp_cl;
> > > 
> > > +
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "%s: command=%02lx is_response=%u status=%02x\n",
> > > +             __func__,
> > > +             out_hdr->command & CMD_MASK,
> > > +             out_hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             out_hdr->status);
> > > +
> > > +     client_data->flag_response = false;
> > > +     rv = ishtp_cl_send(loader_ishtp_cl, msg, msg_size);
> > > +     if (rv < 0) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "ishtp_cl_send error %d\n", rv);
> > > +             return rv;
> > > +     }
> > > +
> > > +     wait_event_interruptible_timeout(client_data-
> > > >cmd_resp_wait,
> > > +                                      client_data-
> > > >flag_response,
> > > +                                      ISHTP_SEND_TIMEOUT);
> > > +     if (!client_data->flag_response) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Timed out for response to command=%02lx",
> > > +                     out_hdr->command & CMD_MASK);
> > > +             return -ETIMEDOUT;
> > > +     }
> > > +
> > > +     /* All response messages will contain a header */
> > > +     data_len = client_data->response_size;
> > > +     in_hdr = (struct loader_msg_hdr *)client_data-
> > > >response_data;
> 
> If process_recv() fails then client_data->response_data could be
> NULL.
> This brings up the question of what to do if process_recv() fails. I
> would think
> that you would want it to set something like client_data-
> >response_error
> and then you could check for that in here and return it. For instance
> right now if the ISH
> doesn't return sizeof(struct loader_msg_hdr) bytes then it would be
> nice to get
> -EMSGSIZE returned from here.
> 
> > > +
> > > +     /* Sanity checks */
> > > +     if (!(in_hdr->command & IS_RESPONSE)) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Invalid response to command\n");
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     if (in_hdr->status) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Loader returned status %d\n",
> > > +                     in_hdr->status);
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     return data_len;
> > > +}
> 
> So I think how you've changed this to handle where the data is stored
> is good,
> but it could be better. I don't like how the users of
> loader_cl_send() need to
> remember to kfree(client_data->response data), and that they just
> implicitly
> assume that client_data->response data holds the result. Instead,
> make the
> callers of loader_cl_send() allocate a buffer to hold the result, and
> then the
> allocating and freeing happens in the same function. I think this is
> a much more
> understandable form of memory management.
> 
> How about this function turns into:
> /**
>  * loader_cl_send()  Send message from host to firmware
>  * @client_data: Client data instance
>  * @in_data: Message buffer to send
>  * @in_size: Size of sent data
>  * @out_data: Buffer to fill with received data.
>  * @out_size: Max number of bytes to place in out_data.
>  *
>  * Return: Number of bytes placed into out_data, negative error code
> on failure.
>  */
> static int loader_cl_send(struct ishtp_cl_data *client_data,
>                                         u8 *in_data, size_t in_size,
>                                         u8 *out_data, size_t
> out_size)
> 
> {
> client_data->response_data = out_data;
> client_data->response_size_max = out_size;
> 
> Send the command.
> Tweak process_recv() so where it does the memcpy() into
> client_data->response_data,
> add the additional check to make sure it doesn't copy more than
> client_data->response_size_max bytes.
> Wait for the completion flag.
> Continue with the rest.
> }
> 
> With these suggestions there are now six pieces of info getting
> transmitted between
> process_recv() and loader_cl_send() via client data:
> client_data->cmd_resp_wait
> client_data->flag_response
> client_data->response_error
> client_data->response_size
> client_data->response_size_max
> client_data->response_data
> Consider turning these into:
> client_data->response_info->wait_queue
> client_data->response_info->data_available // or some better name?
> client_data->response_info->error
> client_data->response_info->size
> client_data->response_info->size_max
> client_data->response_info->data
> for some encapsulation?
> 
> I'm thinking about this more, and basically it seems like we're
> writing a library function to
> send a command to the ISH and receive a response. All the clients who
> use loader_cl_send()
> shouldn't know about the client_data->response_info stuff at all. It
> almost seems like this
> entire functionality should be part of the ISH core? It's really
> limiting that ishtp_cl_send() only
> allows sending and no receiving! It should?!
> 
> > > +
> > > +/**
> > > + * process_recv() -  Receive and parse incoming packet
> > > + * @loader_ishtp_cl: Client instance to get stats
> > > + * @rb_in_proc:              ISH received message buffer
> > > + *
> > > + * Parse the incoming packet. If it is a response packet then it
> > > will
> > > + * update flag_response and wake up the caller waiting to for
> > > the
> > > response.
> > > + */
> > > +static void process_recv(struct ishtp_cl *loader_ishtp_cl,
> > > +                      struct ishtp_cl_rb *rb_in_proc)
> > > +{
> > > +     size_t data_len = rb_in_proc->buf_idx;
> > > +     struct loader_msg_hdr *hdr =
> > > +             (struct loader_msg_hdr *)rb_in_proc->buffer.data;
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     /*
> > > +      * All firmware messages have a header. Check buffer size
> > > +      * before accessing elements inside.
> > > +      */
> > > +     if (data_len < sizeof(struct loader_msg_hdr)) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "data size %zu is less than header %zu\n",
> > > +                     data_len, sizeof(struct loader_msg_hdr));
> > > +             report_bad_packet(client_data->loader_ishtp_cl,
> > > hdr);
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "%s: command=%02lx is_response=%u status=%02x\n",
> > > +             __func__,
> > > +             hdr->command & CMD_MASK,
> > > +             hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             hdr->status);
> > > +
> > > +     switch (hdr->command & CMD_MASK) {
> > > +     case LOADER_CMD_XFER_QUERY:
> > > +     case LOADER_CMD_XFER_FRAGMENT:
> > > +     case LOADER_CMD_START:
> > > +             /* Sanity check */
> > > +             if (client_data->response_data || client_data-
> > > > flag_response) {
> 
> Following advice above, how about checking
> client_data->response_info->data_available instead?
> Or with advice above, corrupting old data might not be an issue,
> since the destination buffer changes? Also I wouldn't call this a
> buffer
> overrun below, it's a different problem.
> 
> > > +                     dev_err(cl_data_to_dev(client_data),
> > > +                             "Buffer overrun: previous firmware
> > > message not yet processed\n");
> > > +                     report_bad_packet(client_data-
> > > >loader_ishtp_cl,
> > > hdr);
> > > +                     break;
> > > +             }
> > > +
> > > +             /*
> > > +              * Copy the buffer received in firmware response
> > > for
> > > the
> > > +              * calling thread.
> > > +              */
> > > +             client_data->response_data = kmalloc(data_len,
> > > GFP_KERNEL);
> > > +             if (!client_data->response_data)
> > > +                     break;
> > > +
> > > +             memcpy(client_data->response_data,
> > > +                    rb_in_proc->buffer.data, data_len);
> > > +             client_data->response_size = data_len;
> > > +
> > > +             /* Free the buffer */
> > > +             ishtp_cl_io_rb_recycle(rb_in_proc);
> > > +             rb_in_proc = NULL;
> > > +
> > > +             /* Wake the calling thread */
> > > +             client_data->flag_response = true;
> > > +             wake_up_interruptible(&client_data->cmd_resp_wait);
> > > +             break;
> > > +
> > > +     default:
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Invalid command=%02lx\n",
> > > +                     hdr->command & CMD_MASK);
> > > +             report_bad_packet(client_data->loader_ishtp_cl,
> > > hdr);
> > > +     }
> > > +
> > > +end_error:
> > > +     /* Free the buffer if we did not do above */
> > > +     if (rb_in_proc)
> > > +             ishtp_cl_io_rb_recycle(rb_in_proc);
> > > +}
> > > +
> > > +/**
> > > + * loader_cl_event_cb() - bus driver callback for incoming
> > > message
> > > + * @device:          Pointer to the the ishtp client device for
> > > which
> > > + *                   this message is targeted
> > > + *
> > > + * Remove the packet from the list and process the message by
> > > calling
> > > + * process_recv
> > > + */
> > > +static void loader_cl_event_cb(struct ishtp_cl_device
> > > *cl_device)
> > > +{
> > > +     struct ishtp_cl_rb *rb_in_proc;
> > > +     struct ishtp_cl_data *client_data;
> > > +     struct ishtp_cl *loader_ishtp_cl =
> > > ishtp_get_drvdata(cl_device);
> > > +
> > > +     client_data = ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     while ((rb_in_proc = ishtp_cl_rx_get_rb(loader_ishtp_cl))
> > > !=
> > > NULL) {
> > > +             if (!rb_in_proc->buffer.data) {
> > > +                     dev_warn(cl_data_to_dev(client_data),
> > > +                              "rb_in_proc->buffer.data returned
> > > null");
> 
> Maybe move this check into process_recv() and then you can set
> client_data->response_info->error for it?
> 
> > > +                     continue;
> > > +             }
> > > +
> > > +             /* Process the data packet from firmware */
> > > +             process_recv(loader_ishtp_cl, rb_in_proc);
> > > +     }
> > > +}
> > > +
> > > +/**
> > > + * ish_query_loader_prop() -  Query ISH Shim firmware loader
> > > + * @client_data:     Client data instance
> > > + * @fw:                      Poiner to fw data struct in host
> > > memory
> > > + *
> > > + * This function queries the ISH Shim firmware loader for
> > > capabilities.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int ish_query_loader_prop(struct ishtp_cl_data
> > > *client_data,
> > > +                              const struct firmware *fw,
> > > +                              struct shim_fw_info *fw_info)
> > > +{
> > > +     int rv;
> > > +     size_t data_len;
> > > +     struct loader_msg_hdr *hdr;
> > > +     struct loader_xfer_query ldr_xfer_query;
> > > +     struct loader_xfer_query_response *ldr_xfer_query_resp;
> > > +
> > > +     memset(&ldr_xfer_query, 0, sizeof(ldr_xfer_query));
> > > +     ldr_xfer_query.hdr.command = LOADER_CMD_XFER_QUERY;
> > > +     ldr_xfer_query.image_size = fw->size;
> > > +     rv = loader_cl_send(client_data,
> > > +                         (u8 *)&ldr_xfer_query,
> > > +                         sizeof(ldr_xfer_query));
> > > +     if (rv < 0) {
> > > +             client_data->flag_retry = true;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     /* Check buffer size before accessing the elements */
> > > +     data_len = client_data->response_size;
> 
> Use rv instead of client_data->response_size, we want to minimize
> weird
> unexplainable accesses of the fileds of client_data.
> 
> Also consider not using the variable data_len, it doesn't do too much
> besides
> cause some indirection. With the change above it should be obvious
> what is going on.
> 
> > > +     if (data_len != sizeof(struct loader_xfer_query_response))
> > > {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "data size %zu is not equal to size of
> > > loader_xfer_query_response %zu\n",
> > > +                     data_len, sizeof(struct
> > > loader_xfer_query_response));
> > > +             hdr = (struct loader_msg_hdr *)client_data-
> > > > response_data;
> 
> Following suggestion above you'll use the
> 
> > > +             report_bad_packet(client_data->loader_ishtp_cl,
> > > hdr);
> > > +             client_data->flag_retry = true;
> > > +             rv = -EMSGSIZE;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     /* Save fw_info for use outside this function */
> > > +     ldr_xfer_query_resp =
> > > +             (struct loader_xfer_query_response *)client_data-
> > > > response_data;
> > > 
> > > +     *fw_info = ldr_xfer_query_resp->fw_info;
> > > +
> > > +     /* Loader firmware properties */
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "ish_fw_version: major=%d minor=%d hotfix=%d
> > > build=%d
> > > protocol_version=0x%x loader_version=%d\n",
> > > +             fw_info->ish_fw_version.major,
> > > +             fw_info->ish_fw_version.minor,
> > > +             fw_info->ish_fw_version.hotfix,
> > > +             fw_info->ish_fw_version.build,
> > > +             fw_info->protocol_version,
> > > +             fw_info->ldr_version.value);
> > > +
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "loader_capability: max_fw_image_size=0x%x
> > > xfer_mode=%d
> > > max_dma_buf_size=0x%x dma_buf_size_limit=0x%x\n",
> > > +             fw_info->ldr_capability.max_fw_image_size,
> > > +             fw_info->ldr_capability.xfer_mode,
> > > +             fw_info->ldr_capability.max_dma_buf_size,
> > > +             dma_buf_size_limit);
> > > +
> > > +     /* Sanity checks */
> > > +     if (fw_info->ldr_capability.max_fw_image_size < fw->size) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "ISH firmware size %zu is greater than Shim
> > > firmware loader max supported %d\n",
> > > +                     fw->size,
> > > +                     fw_info->ldr_capability.max_fw_image_size);
> > > +             rv = -ENOSPC;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     /* For DMA the buffer size should be multiple of cacheline
> > > size
> > > */
> > > +     if ((fw_info->ldr_capability.xfer_mode &
> > > LOADER_XFER_MODE_DIRECT_DMA) &&
> > > +         (fw_info->ldr_capability.max_dma_buf_size %
> > > L1_CACHE_BYTES)) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Shim firmware loader buffer size %d should
> > > be
> > > multipe of cacheline\n",
> > > +                     fw_info->ldr_capability.max_dma_buf_size);
> > > +             rv = -EINVAL;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +end_error:
> > > +     /* Free ISH buffer if not done so in error case */
> > > +     kfree(client_data->response_data);
> > > +     client_data->response_data = NULL;
> > > +     return rv;
> > > +}
> > > +
> > > +/**
> > > + * ish_fw_xfer_ishtp()       Loads ISH firmware using ishtp
> > > interface
> > > + * @client_data:     Client data instance
> > > + * @fw:                      Pointer to fw data struct in host
> > > memory
> > > + *
> > > + * This function uses ISH-TP to transfer ISH firmware from host
> > > to
> > > + * ISH SRAM. Lower layers may use IPC or DMA depending on
> > > firmware
> > > + * support.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int ish_fw_xfer_ishtp(struct ishtp_cl_data *client_data,
> > > +                          const struct firmware *fw)
> > > +{
> > > +     int rv;
> > > +     u32 fragment_offset, fragment_size, payload_max_size;
> > > +     struct loader_xfer_ipc_fragment *ldr_xfer_ipc_frag;
> > > +
> > > +     payload_max_size =
> > > +             LOADER_SHIM_IPC_BUF_SIZE -
> > > IPC_FRAGMENT_DATA_PREAMBLE;
> > > +
> > > +     ldr_xfer_ipc_frag = kzalloc(LOADER_SHIM_IPC_BUF_SIZE,
> > > GFP_KERNEL);
> > > +     if (!ldr_xfer_ipc_frag) {
> > > +             client_data->flag_retry = true;
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     ldr_xfer_ipc_frag->fragment.hdr.command =
> > > LOADER_CMD_XFER_FRAGMENT;
> > > +     ldr_xfer_ipc_frag->fragment.xfer_mode =
> > > LOADER_XFER_MODE_ISHTP;
> > > +
> > > +     /* Break the firmware image into fragments and send as ISH-
> > > TP
> > > payload */
> > > +     fragment_offset = 0;
> > > +     while (fragment_offset < fw->size) {
> > > +             if (fragment_offset + payload_max_size < fw->size)
> > > {
> > > +                     fragment_size = payload_max_size;
> > > +                     ldr_xfer_ipc_frag->fragment.is_last = 0;
> > > +             } else {
> > > +                     fragment_size = fw->size - fragment_offset;
> > > +                     ldr_xfer_ipc_frag->fragment.is_last = 1;
> > > +             }
> > > +
> > > +             ldr_xfer_ipc_frag->fragment.offset =
> > > fragment_offset;
> > > +             ldr_xfer_ipc_frag->fragment.size = fragment_size;
> > > +             memcpy(ldr_xfer_ipc_frag->data,
> > > +                    &fw->data[fragment_offset],
> > > +                    fragment_size);
> > > +
> > > +             dev_dbg(cl_data_to_dev(client_data),
> > > +                     "xfer_mode=ipc offset=0x%08x size=0x%08x
> > > is_last=%d\n",
> > > +                     ldr_xfer_ipc_frag->fragment.offset,
> > > +                     ldr_xfer_ipc_frag->fragment.size,
> > > +                     ldr_xfer_ipc_frag->fragment.is_last);
> > > +
> > > +             rv = loader_cl_send(client_data,
> > > +                                 (u8 *)ldr_xfer_ipc_frag,
> > > +                                 IPC_FRAGMENT_DATA_PREAMBLE +
> > > fragment_size);
> > > +             if (rv < 0) {
> > > +                     client_data->flag_retry = true;
> > > +                     goto end_err_resp_buf_release;
> > > +             }
> > > +
> > > +             /* Free ISH buffer once response is processed */
> > > +             kfree(client_data->response_data);
> > > +             client_data->response_data = NULL;
> > > +
> > > +             fragment_offset += fragment_size;
> > > +     }
> > > +
> > > +     kfree(ldr_xfer_ipc_frag);
> > > +     return 0;
> > > +
> > > +end_err_resp_buf_release:
> > > +     /* Free ISH buffer if not done already, in error case */
> > > +     kfree(client_data->response_data);
> > > +     client_data->response_data = NULL;
> > > +     kfree(ldr_xfer_ipc_frag);
> > > +     return rv;
> > > +}
> > > +
> > > +/**
> > > + * ish_fw_xfer_direct_dma() - Loads ISH firmware using direct
> > > dma
> > > + * @client_data:     Client data instance
> > > + * @fw:                      Poiner to fw data struct in host
> > > memory
> > > + *
> > > + * Host firmware load is a unique case where we need to download
> > > + * a large firmware image (200+ Kb). This function implements
> > > + * direct DMA transfer in kernel and ISH firmware. This allows
> > > + * us to overcome the ISH-TP 4 Kb limit, and allows us to DMA
> > > + * directly to ISH UMA at location of choice.
> > > + * Function depends on corresponding support in ISH firmware.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int ish_fw_xfer_direct_dma(struct ishtp_cl_data
> > > *client_data,
> > > +                               const struct firmware *fw,
> > > +                               struct shim_fw_info fw_info)
> > > +{
> > > +     int rv;
> > > +     void *dma_buf;
> > > +     dma_addr_t dma_buf_phy;
> > > +     u32 fragment_offset, fragment_size, payload_max_size;
> > > +     struct loader_xfer_dma_fragment ldr_xfer_dma_frag;
> > > +     struct device *devc = ishtp_get_pci_device(client_data-
> > > > cl_device);
> > > 
> > > +     u32 shim_fw_buf_size =
> > > +             fw_info.ldr_capability.max_dma_buf_size;
> > > +
> > > +     /*
> > > +      * payload_max_size should be set to minimum of
> > > +      *  (1) Size of firmware to be loaded,
> > > +      *  (2) Max DMA buf size supported by Shim firmware,
> > > +      *  (3) DMA buffer size limit set by boot_param
> > > dma_buf_size_limit.
> > > +      */
> > > +     payload_max_size = min3(fw->size,
> > > +                             (size_t)shim_fw_buf_size,
> > > +                             (size_t)dma_buf_size_limit);
> > > +
> > > +     /*
> > > +      * Buffer size should be multiple of cacheline size
> > > +      * if it's not, select the previous cacheline boundary.
> > > +      */
> > > +     payload_max_size &= ~(L1_CACHE_BYTES - 1);
> > > +
> > > +     dma_buf = kmalloc(payload_max_size, GFP_KERNEL |
> > > GFP_DMA32);
> > > +     if (!dma_buf) {
> > > +             client_data->flag_retry = true;
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     dma_buf_phy = dma_map_single(devc, dma_buf,
> > > payload_max_size,
> > > +                                  DMA_TO_DEVICE);
> > > +     if (dma_mapping_error(devc, dma_buf_phy)) {
> > > +             dev_err(cl_data_to_dev(client_data), "DMA map
> > > failed\n");
> > > +             client_data->flag_retry = true;
> > > +             rv = -ENOMEM;
> > > +             goto end_err_dma_buf_release;
> > > +     }
> > > +
> > > +     ldr_xfer_dma_frag.fragment.hdr.command =
> > > LOADER_CMD_XFER_FRAGMENT;
> > > +     ldr_xfer_dma_frag.fragment.xfer_mode =
> > > LOADER_XFER_MODE_DIRECT_DMA;
> > > +     ldr_xfer_dma_frag.ddr_phys_addr = (u64)dma_buf_phy;
> > > +
> > > +     /* Send the firmware image in chucks of payload_max_size */
> > > +     fragment_offset = 0;
> > > +     while (fragment_offset < fw->size) {
> > > +             if (fragment_offset + payload_max_size < fw->size)
> > > {
> > > +                     fragment_size = payload_max_size;
> > > +                     ldr_xfer_dma_frag.fragment.is_last = 0;
> > > +             } else {
> > > +                     fragment_size = fw->size - fragment_offset;
> > > +                     ldr_xfer_dma_frag.fragment.is_last = 1;
> > > +             }
> > > +
> > > +             ldr_xfer_dma_frag.fragment.offset =
> > > fragment_offset;
> > > +             ldr_xfer_dma_frag.fragment.size = fragment_size;
> > > +             memcpy(dma_buf, &fw->data[fragment_offset],
> > > fragment_size);
> > > +
> > > +             dma_sync_single_for_device(devc, dma_buf_phy,
> > > +                                        payload_max_size,
> > > +                                        DMA_TO_DEVICE);
> > > +
> > > +             /*
> > > +              * Flush cache here because the
> > > dma_sync_single_for_device()
> > > +              * does not do for x86.
> > > +              */
> > > +             clflush_cache_range(dma_buf, payload_max_size);
> > > +
> > > +             dev_dbg(cl_data_to_dev(client_data),
> > > +                     "xfer_mode=dma offset=0x%08x size=0x%x
> > > is_last=%d ddr_phys_addr=0x%016llx\n",
> > > +                     ldr_xfer_dma_frag.fragment.offset,
> > > +                     ldr_xfer_dma_frag.fragment.size,
> > > +                     ldr_xfer_dma_frag.fragment.is_last,
> > > +                     ldr_xfer_dma_frag.ddr_phys_addr);
> > > +
> > > +             rv = loader_cl_send(client_data,
> > > +                                 (u8 *)&ldr_xfer_dma_frag,
> > > +                                 sizeof(ldr_xfer_dma_frag));
> > > +             if (rv < 0) {
> > > +                     client_data->flag_retry = true;
> > > +                     goto end_err_resp_buf_release;
> > > +             }
> > > +
> > > +             /* Free ISH buffer once response is processed */
> > > +             kfree(client_data->response_data);
> > > +             client_data->response_data = NULL;
> > > +
> > > +             fragment_offset += fragment_size;
> > > +     }
> > > +
> > > +     dma_unmap_single(devc, dma_buf_phy, payload_max_size,
> > > DMA_TO_DEVICE);
> > > +     kfree(dma_buf);
> > > +     return 0;
> > > +
> > > +end_err_resp_buf_release:
> > > +     /* Free ISH buffer if not done already, in error case */
> > > +     kfree(client_data->response_data);
> > > +     client_data->response_data = NULL;
> > > +     dma_unmap_single(devc, dma_buf_phy, payload_max_size,
> > > DMA_TO_DEVICE);
> > > +end_err_dma_buf_release:
> > > +     kfree(dma_buf);
> > > +     return rv;
> > > +}
> > > +
> > > +/**
> > > + * ish_fw_start()    Start executing ISH main firmware
> > > + * @client_data:     client data instance
> > > + *
> > > + * This function sends message to Shim firmware loader to start
> > > + * the execution of ISH main firmware.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int ish_fw_start(struct ishtp_cl_data *client_data)
> > > +{
> > > +     int rv;
> > > +     struct loader_start ldr_start;
> > > +
> > > +     memset(&ldr_start, 0, sizeof(ldr_start));
> > > +     ldr_start.hdr.command = LOADER_CMD_START;
> > > +     rv = loader_cl_send(client_data,
> > > +                         (u8 *)&ldr_start,
> > > +                         sizeof(ldr_start));
> > > +
> > > +     /* Free ISH buffer once response is processed */
> > > +     kfree(client_data->response_data);
> > > +     client_data->response_data = NULL;
> > > +     return rv;
> > > +}
> > > +
> > > +/**
> > > + * load_fw_from_host()       Loads ISH firmware from host
> > > + * @client_data:     Client data instance
> > > + *
> > > + * This function loads the ISH firmware to ISH sram and starts
> > > execution
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int load_fw_from_host(struct ishtp_cl_data *client_data)
> > > +{
> > > +     int rv;
> > > +     u32 xfer_mode;
> > > +     char *filename;
> > > +     const struct firmware *fw;
> > > +     struct shim_fw_info fw_info;
> > > +
> > > +     client_data->flag_retry = false;
> > > +
> > > +     filename = kzalloc(FILENAME_SIZE, GFP_KERNEL);
> > > +     if (!filename) {
> > > +             rv = -ENOMEM;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     /* Get filename of the ISH firmware to be loaded */
> > > +     rv = get_firmware_variant(client_data, filename);
> > > +     if (rv < 0)
> > > +             goto end_err_filename_buf_release;
> > > +
> > > +     rv = request_firmware(&fw, filename,
> > > cl_data_to_dev(client_data));
> > > +     if (rv < 0)
> > > +             goto end_err_filename_buf_release;
> > > +
> > > +     /* Step 1: Query Shim firmware loader properties */
> > > +
> > > +     rv = ish_query_loader_prop(client_data, fw, &fw_info);
> > > +     if (rv < 0)
> > > +             goto end_err_fw_release;
> > > +
> > > +     /* Step 2: Send the main firmware image to be loaded, to
> > > ISH
> > > sram */
> > > +
> > > +     xfer_mode = fw_info.ldr_capability.xfer_mode;
> > > +     if (xfer_mode & LOADER_XFER_MODE_DIRECT_DMA) {
> > > +             rv = ish_fw_xfer_direct_dma(client_data, fw,
> > > fw_info);
> > > +     } else if (xfer_mode & LOADER_XFER_MODE_ISHTP) {
> > > +             rv = ish_fw_xfer_ishtp(client_data, fw);
> > > +     } else {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "No transfer mode selected in firmware\n");
> > > +             rv = -EINVAL;
> > > +     }
> > > +     if (rv < 0)
> > > +             goto end_err_fw_release;
> > > +
> > > +     /* Step 3: Start ISH main firmware exeuction */
> > > +
> > > +     rv = ish_fw_start(client_data);
> > > +     if (rv < 0)
> > > +             goto end_err_fw_release;
> > > +
> > > +     release_firmware(fw);
> > > +     kfree(filename);
> > > +     dev_info(cl_data_to_dev(client_data), "ISH firmware %s
> > > loaded\n",
> > > +              filename);
> > > +     return 0;
> > > +
> > > +end_err_fw_release:
> > > +     release_firmware(fw);
> > > +end_err_filename_buf_release:
> > > +     kfree(filename);
> > > +end_error:
> > > +     if (client_data->flag_retry) {
> > > +             dev_warn(cl_data_to_dev(client_data),
> > > +                      "ISH host firmware load failed %d. Reset
> > > ISH &
> > > try again..\n",
> > > +                      rv);
> > > +             loader_ish_hw_reset(client_data->loader_ishtp_cl);
> 
> This could just keep failing infinitely, right? Do you want to add
> some retry counter,
> and after some limit then give up or something? What happens if the
> ISH firmware
> never succeeds in loading?
> 
> > > +     } else {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "ISH host firmware load failed %d\n", rv);
> > > +     }
> > > +     return rv;
> > > +}
> 
> And there were many typos in comments that I saw, comb through them
> carefully again.
> 
> Cheers,
> Nick
